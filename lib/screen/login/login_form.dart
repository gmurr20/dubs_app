import 'package:dubs_app/bloc/login/login_bloc.dart';
import 'package:dubs_app/bloc/login/login_events.dart';
import 'package:dubs_app/bloc/login/login_states.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:dubs_app/screen/home/home_page.dart';
import 'package:dubs_app/screen/verify_user/tutorial/tutorial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;

  LoginForm({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  PanelController _pc = PanelController();

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _loginBloc = LoginBloc(userRepo: _userRepository);
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  double _currentWidth() {
    return MediaQuery.of(context).size.width;
  }

  // Event when login button is pressed
  _onLoginButtonPressed() {
    _loginBloc
        .add(LoginUserEvent(_emailController.text, _passwordController.text));
  }

  // returns an email error message based on the state
  String _emailError(LoginState state) {
    if (state is InvalidInputState) {
      return state.emailError;
    }
    return null;
  }

  // returns an email error message based on the state
  String _passwordError(LoginState state) {
    if (state is InvalidInputState) {
      return state.passwordError;
    }
    return null;
  }

  Widget _buildEmailForm(LoginState state) {
    return Stack(children: [
      Container(
        width: _currentWidth(),
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Container(
                child: TextFormField(
                    style: darkprimaryPRegular,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      filled: true,
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Email Address",
                      fillColor: Colors.white,
                      helperText: ' ',
                      errorText: _emailError(state),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    controller: _emailController)),
            Container(
              child: TextFormField(
                  style: darkprimaryPRegular,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    labelText: "Password",
                    fillColor: Colors.white,
                    helperText: ' ',
                    errorText: _passwordError(state),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  controller: _passwordController,
                  obscureText: true),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 16),
              width: _currentWidth() * 0.4,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                onPressed: (state is! LoginLoadingState
                    ? _onLoginButtonPressed
                    : null),
                child: Text('Login', style: darkprimaryPBold),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _loginBloc,
        listener: (
          BuildContext context,
          LoginState state,
        ) {
          if (state is LoggedInState) {
            switch (state.user.authState) {
              case UserAuthState.FULLY_LOGGED_IN:
                {
                  Navigator.of(context)
                      .pushNamed(homeRoute, arguments: state.user);
                  return;
                }
              case UserAuthState.NOT_VERIFIED:
                {
                  Navigator.of(context)
                      .pushNamed(verifyUserRoute, arguments: state.user);
                  return;
                }
              case UserAuthState.NO_USERNAME:
                {
                  Navigator.of(context)
                      .pushNamed(addUsernameRoute, arguments: state.user);
                  return;
                }
            }
          }
        },
        child: BlocBuilder(
          bloc: _loginBloc,
          builder: (
            BuildContext context,
            LoginState state,
          ) {
            if (state is AuthenticationErrorState) {
              _onWidgetDidBuild(() {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.errorMessage}'),
                    backgroundColor: Colors.white,
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
                ),
              ),
            );
          },
        ));
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
