import 'package:dubs_app/bloc/login/login_bloc.dart';
import 'package:dubs_app/bloc/login/login_events.dart';
import 'package:dubs_app/bloc/login/login_states.dart';
import 'package:dubs_app/component/login_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;

  LoginForm({Key key, @required this.loginBloc}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginErrorState) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 155.0,
                        child: Image.asset(
                          "assets/temp_logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 35.0),
                      TextFormField(
                        decoration: createTextBoxDecoration("email"),
                        controller: _emailController,
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        decoration: createTextBoxDecoration("password"),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: state is! LoginLoadingState
                            ? _onLoginButtonPressed
                            : null,
                        child: Text('Login'),
                      ),
                      Container(
                        child: state is LoginLoadingState
                            ? CircularProgressIndicator()
                            : null,
                      ),
                    ],
                  ),
                )));
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc
        .add(LoginUserEvent(_emailController.text, _passwordController.text));
  }
}
