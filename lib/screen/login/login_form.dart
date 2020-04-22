import 'package:dubs_app/bloc/login/login_bloc.dart';
import 'package:dubs_app/bloc/login/login_events.dart';
import 'package:dubs_app/bloc/login/login_states.dart';
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

  double _currentWidth() {
    return MediaQuery.of(context).size.width;
  }

  Widget _buildEmailForm(LoginState state) {
    return Container(
      width: _currentWidth(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
            width: _currentWidth() * .7,
            child: Text(
              "Email Login",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              width: _currentWidth() * 0.7,
              height: 40,
              margin: EdgeInsets.only(top: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "email",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(),
                  ),
                ),
                controller: _emailController,
              )),
          Container(
            width: _currentWidth() * 0.7,
            height: 40,
            margin: EdgeInsets.only(top: 16),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "password",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              controller: _passwordController,
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            width: _currentWidth() * 0.3,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.lightBlue[100],
              onPressed:
                  (state is! LoginLoadingState ? _onLoginButtonPressed : null),
              child: Text('Login', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

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
                      _buildEmailForm(state),
                      Container(
                        child: state is LoginLoadingState
                            ? CircularProgressIndicator()
                            : null,
                      )
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
