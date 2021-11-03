import 'package:sfs_poc/oauth/form_submission_status.dart';

class LoginState {
  final String username;
  bool get isValiedUserName => username.length > 3;

  final String password;
  bool get isValiedPassword => password.length > 6;

  final String jsonData;

  FormSubmissionStatus formStatus;

  ResetFormStatus() async {
    formStatus = const InitialFormStatus();
  }

  LoginState(
      {this.username = '',
      this.password = '',
      this.formStatus = const InitialFormStatus(),
      this.jsonData = ''});
  LoginState copyWith(
      {String? username,
      String? password,
      FormSubmissionStatus? formStatus,
      String? jsonData}) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        jsonData: jsonData ?? this.jsonData);
  }
}
