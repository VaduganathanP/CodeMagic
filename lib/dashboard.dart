import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'oauth/Login/login_view.dart';
import 'oauth/auth_repository.dart';

class Dashboard extends StatelessWidget {
  final String jsontext;
  const Dashboard({Key? key, required this.jsontext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _moveToScreen2(context);
            }),
        title: const Text('Dashboard',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30.0,
                color: Colors.white)),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Center(
              child: SingleChildScrollView(
                  child: Column(children: [
            Text(
              jsontext,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.0,
                  color: Colors.black),
            )
          ])))),
    );
  }
}

Future<T?> pushPage<T>(BuildContext context, Widget page) {
  return Navigator.of(context)
      .push<T>(MaterialPageRoute(builder: (context) => LoginView()));
}

void _moveToScreen2(BuildContext context) =>
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MaterialApp(
              home: RepositoryProvider(
                create: (context) => AuthRepository(),
                child: LoginView(),
              ),
              debugShowCheckedModeBanner: true,
            )));
