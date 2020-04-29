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
              "Create Account",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              width: _currentWidth() * .7,
              margin: EdgeInsets.only(top: 16),
              height: 60,
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "email",
                    fillColor: Colors.white,
                    helperText: ' ',
                    errorText: _emailError(state),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  controller: _emailController)),
          Container(
            width: _currentWidth() * 0.7,
            margin: EdgeInsets.only(top: 8),
            height: 60,
            child: TextFormField(
                decoration: InputDecoration(
                  labelText: "password",
                  fillColor: Colors.white,
                  helperText: ' ',
                  errorText: _password1Error(state),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                controller: _password1Controller,
                obscureText: true),
          ),
          Container(
            width: _currentWidth() * 0.7,
            margin: EdgeInsets.only(top: 8),
            height: 60,
            child: TextFormField(
                decoration: InputDecoration(
                  labelText: "confirm password",
                  fillColor: Colors.white,
                  helperText: ' ',
                  errorText: _password2Error(state),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
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
              color: Colors.lightBlue[100],
              onPressed:
                  (state is! LoadingState ? _onCreateUserButtonPressed : null),
              child: Text('Sign up', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
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
