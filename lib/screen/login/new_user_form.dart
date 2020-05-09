import 'package:dubs_app/bloc/new_user/new_user_bloc.dart';
import 'package:dubs_app/bloc/new_user/new_user_events.dart';
import 'package:dubs_app/bloc/new_user/new_user_states.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        padding: EdgeInsets.only(top: 5),
        margin: EdgeInsets.only(left: 2, right: 0),
        child: Text(
          'Create Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
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
                  labelStyle: TextStyle(color: Colors.white),
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
                labelStyle: TextStyle(color: Colors.white),
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
              labelStyle: TextStyle(color: Colors.white),
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
    return BlocBuilder(
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
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
