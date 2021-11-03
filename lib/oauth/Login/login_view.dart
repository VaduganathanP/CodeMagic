import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfs_poc/oauth/Login/login_bloc.dart';
import 'package:sfs_poc/oauth/Login/login_event.dart';
import 'package:sfs_poc/oauth/Login/login_state.dart';
import 'package:sfs_poc/oauth/auth_repository.dart';
import 'package:sfs_poc/oauth/form_submission_status.dart';

import '../../dashboard.dart';

// ignore: use_key_in_widget_constructors
class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) =>
              LoginBloc(authRepository: context.read<AuthRepository>()),
          child: _loginForm()),
      appBar: AppBar(
        title: const Text('Smart Structures',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30.0,
                color: Colors.white)),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailure) {
          _showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionError) {
          _showSnackBar(context, formStatus.errorMessage);
        } else if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, "Login Success!");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Dashboard(
                    jsontext: state.jsonData,
                  )));
        }
      },
      child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 60.0,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 25,
                ),
                _usernameField(),
                const SizedBox(
                  height: 20,
                ),
                _passwordField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        print('Forgotted Password!');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: _loginButton(),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  color: Colors.black,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('''Don't have an account? ''',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.0,
                        )),
                    TextButton(
                      onPressed: () {
                        print('Sign Up');
                      },
                      child: const Text('Register Now'),
                    )
                  ],
                ),
              ],
            )),
          )),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          labelText: 'Email Address',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email),
        ),
        validator: (value) =>
            state.isValiedUserName ? null : 'User Name is not Valied!',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginUserNameChanged(username: value)),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: Icon(Icons.remove_red_eye),
        ),
        validator: (value) =>
            state.isValiedPassword ? null : 'Password is not Valied!',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<LoginBloc>().add(LoginSubmitted());
          }
        },
        child: Text('Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            )),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    var _snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Color.fromARGB(200, 255, 99, 71),
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }
}
