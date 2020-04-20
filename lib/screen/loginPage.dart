import 'package:dubs_app/bloc/login/login_bloc.dart';
import 'package:dubs_app/bloc/login/login_events.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/loginForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _loginBloc = LoginBloc(userRepo: _userRepository);
    _loginBloc.add(AppStartEvent());
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginForm(loginBloc: _loginBloc),
    );
  }
}
