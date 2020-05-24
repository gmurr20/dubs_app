import 'package:dubs_app/bloc/new_user/new_user_bloc.dart';
import 'package:dubs_app/bloc/new_user/new_user_events.dart';
import 'package:dubs_app/bloc/new_user/new_user_states.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';

class NewUserForm extends StatefulWidget {
  final UserRepository userRepository;

  NewUserForm({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  NewUserBloc _newUserBloc;
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _newUserBloc = NewUserBloc(userRepo: _userRepository);
  }

  @override
  void dispose() {
    _newUserBloc.close();
    super.dispose();
  }

  double _currentWidth() {
    return MediaQuery.of(context).size.width;
  }

  // Event when create user button is pressed
  _onCreateUserButtonPressed() {
    _newUserBloc.add(AddUserEvent(_emailController.text, "",
        _password1Controller.text, _password2Controller.text));
  }

  String _emailError(NewUserState state) {
    if (state is InvalidInputState) {
      return state.emailError;
    }
  }

  String _password1Error(NewUserState state) {
    if (state is InvalidInputState) {
      return state.password1Error;
    }
  }

  String _password2Error(NewUserState state) {
    if (state is InvalidInputState) {
      return state.password2Error;
    }
  }

  Widget _buildNewUserForm(NewUserState state) {
    return Column(children: [
      Container(
        alignment: Alignment.topLeft,
        padding: spacer.top.xxs,
        margin: spacer.left.none,
        child: Text(
          'Create Account',
          style: primaryH1Bold,
          textAlign: TextAlign.left,
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 25),
          child: TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  labelText: "email",
                  labelStyle: primaryPRegular,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  helperText: ' ',
                  errorText: _emailError(state)),
              controller: _emailController)),
      Container(
        child: TextFormField(
            style: TextStyle(fontSize: 14, color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
                labelText: "password",
                labelStyle: primaryPRegular,
                fillColor: Colors.white,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                helperText: ' ',
                errorText: _password1Error(state)),
            controller: _password1Controller,
            obscureText: true),
      ),
      Container(
        child: TextFormField(
            style: TextStyle(fontSize: 14, color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelText: "confirm password",
              labelStyle: primaryPRegular,
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              helperText: ' ',
              errorText: _password2Error(state),
            ),
            controller: _password2Controller,
            obscureText: true),
      ),
      Container(
          margin: EdgeInsets.only(top: 8, bottom: 16),
          width: _currentWidth() * 0.3,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            onPressed:
                (state is! LoadingState ? _onCreateUserButtonPressed : null),
            child: Text('Sign up', style: TextStyle(color: Colors.black)),
          )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _newUserBloc,
      listener: (
        BuildContext context,
        NewUserState state,
      ) {
        if (state is LoggedInState) {
          Navigator.of(context).pushNamed(verifyUserRoute);
        }
      },
      child: BlocBuilder(
          bloc: _newUserBloc,
          builder: (
            BuildContext context,
            NewUserState state,
          ) {
            if (state is LoginErrorState) {
              _onWidgetDidBuild(() {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
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
                          _buildNewUserForm(state),
                          Container(
                            child: state is LoadingState
                                ? CircularProgressIndicator()
                                : null,
                          )
                        ],
                      ),
                    )));
          }),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
