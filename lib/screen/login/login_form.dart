import 'package:dubs_app/bloc/login/login_bloc.dart';
import 'package:dubs_app/bloc/login/login_events.dart';
import 'package:dubs_app/bloc/login/login_states.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';

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
              alignment: Alignment.topLeft,
              padding: spacer.top.xxs,
              margin: spacer.left.none,
              child: Text(
                "Email Login",
                style: darkprimaryH1Bold,
              ),
            ),
            Container(
                child: TextFormField(
                    style: darkprimaryPRegular,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      fillColor: Colors.white,
                      helperText: ' ',
                      errorText: _emailError(state),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    controller: _emailController)),
            Container(
              child: TextFormField(
                  style: darkprimaryPRegular,
                  decoration: InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    helperText: ' ',
                    errorText: _passwordError(state),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
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
                color: DarwinRed,
                onPressed: (state is! LoginLoadingState
                    ? _onLoginButtonPressed
                    : null),
                child: Text('Login', style: primaryPBold),
              ),
            ),
          ],
        ),
      )
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
            Navigator.of(context).pushNamed(homeRoute);
          } else if (state is UnverifiedUserState) {
            Navigator.of(context).pushNamed(verifyUserRoute);
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
                    backgroundColor: Colors.red,
                  ),
                );
              });
            }
            if (state is AuthenticationErrorState) {
              _onWidgetDidBuild(() {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.errorMessage}'),
                    backgroundColor: Colors.red,
                  ),
                );
              });
            }
            return WillPopScope(
              onWillPop: () {
                _loginBloc.add(AppStartEvent());
                return Future.value(false);
              },
              child: Form(
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
