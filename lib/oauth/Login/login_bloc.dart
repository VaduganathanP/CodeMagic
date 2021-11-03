import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfs_poc/Models/User.dart';
import 'package:sfs_poc/dashboard.dart';
import 'package:sfs_poc/oauth/Login/login_event.dart';
import 'package:sfs_poc/oauth/Login/login_state.dart';
import 'package:sfs_poc/oauth/auth_repository.dart';
import 'package:sfs_poc/oauth/form_submission_status.dart';
import 'package:http/http.dart' as http;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginState());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserNameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(
          username: state.username,
          password: state.password,
          formStatus: FormSubmitting());
      try {
        var response = await _loginApiCall(state.username, state.password);
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        final _formKey = GlobalKey<FormState>();
        if (decodedResponse['response']['isError']) {
          yield state.copyWith(formStatus: SubmissionError('Login Error'));
        } else {
          User user = User(
              email: decodedResponse['identity']['userName'],
              firstname: decodedResponse['identity']['firstName'],
              lastname: decodedResponse['identity']['lastName'],
              isloggedin: true,
              id: 0);
          user.passwordhash = decodedResponse['identity']['passwordHash'];
          user.createddatetimeutc = DateTime.now().toUtc();
          user.expireson = decodedResponse['license']['validity']['to'];
          user.plan = decodedResponse['license']['plans'][0];
          authRepository.AddOrUpdateUser(user);
          yield state.copyWith(
              formStatus: SubmissionSuccess(),
              jsonData: decodedResponse.toString());
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailure(e as Exception));
      }
    }
  }

  Future<http.Response> _loginApiCall(username, password) async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https(
              'smarthub-dev.azurewebsites.net', 'portal/license/validate'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'systemInfo': {
              'machine': {'serialNumber': null, 'uuid': null},
              'hostName': 'SS-WS0060',
              'osVersion': null,
              'osManufacturer': null,
              'deviceId': '00330-50000-00000-AAOEM',
              'systemManufacturer': null,
              'systemModel': null,
              'systemType': null,
              'systemLocale': null,
              'timeZone': null,
              'totalPhysicalMemory': null,
              'availablePhysicalMemory': null,
              'processors': null,
              'platform': 0
            },
            'license': {
              'serialNumber': null,
              'validity': null,
              'dalExceed': false,
              'deviceIds': null,
              'software': {
                'version': '2.4',
                'build': '2105201300',
                'name': 'Smart Field Sheet',
                'manualUrl': null,
                'productUid': 'b2b1a360-3f9f-4c24-b671-bfaa82f4ee89'
              },
              'plans': null,
              'upgrade ': null
            },
            'identity': {
              'isValid': false,
              'userName': username,
              'password': password,
              'firstName': null,
              'lastName': null,
              'tin': null,
              'roles': null,
              'phoneNumber': null,
              'organization': null,
              'certification': null,
              'isInternalUser': false,
              'isDeveloper': false
            },
            'response': null,
            'incident': null,
            'events': null,
            'cmt': {'projectPurpose': []}
          }));
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return response;
    } finally {
      client.close();
    }
  }
}
