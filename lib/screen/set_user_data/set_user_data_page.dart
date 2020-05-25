import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/bloc/set_user_data/set_user_data_bloc.dart';
import 'package:dubs_app/bloc/set_user_data/set_user_data_events.dart';
import 'package:dubs_app/bloc/set_user_data/set_user_data_states.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetUserDataPage extends StatefulWidget {
  final UserRepository userRepository;

  SetUserDataPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<SetUserDataPage> createState() => _SetUserDataPageState();
}

class _SetUserDataPageState extends State<SetUserDataPage> {
  UserRepository get _userRepository => widget.userRepository;
  SetUserDataBloc _bloc;

  final _usernameController = TextEditingController();

  @override
  void initState() {
    _bloc = SetUserDataBloc(userRepo: _userRepository);
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _setUserDataAction() {
    _bloc.add(SetInfoEvent(MutableUserData(_usernameController.text)));
  }

  String _usernameError(SetUserDataState state) {
    if (state is ErrorState) {
      return state.usernameError;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (
        BuildContext context,
        SetUserDataState state,
      ) {
        if (state is DataSetState) {
          Navigator.of(context).pushNamed(homeRoute);
        }
        if (state is NotLoggedInState) {
          Navigator.of(context).pushNamed(loginRoute);
        }
      },
      child: BlocBuilder(
          bloc: _bloc,
          builder: (
            BuildContext context,
            SetUserDataState state,
          ) {
            return Scaffold(
                body: Container(
                    child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                padding: spacer.top.xxs,
                margin: spacer.left.none,
                child: Text(
                  'Set Username',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                child: TextFormField(
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        labelText: "username",
                        labelStyle: primaryPRegular,
                        fillColor: Colors.black,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        helperText: ' ',
                        errorText: _usernameError(state)),
                    controller: _usernameController),
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: _setUserDataAction,
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.grey,
              )
            ])));
          }),
    );
  }
}
