import 'package:dubs_app/DesignSystem/colors.dart';
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
                backgroundColor: DarwinRed,
                body: Container(
                    child: Column(children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: spacer.top.lg,
                    margin: spacer.left.md + spacer.bottom.xs,
                    child: Text(
                      'Create your username',
                      style: primaryH1Bold,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: spacer.left.md + spacer.bottom.sm + spacer.right.md,
                    child: Text(
                      'Make it simple! This username is how your friends will find and connect with you.',
                      style: primaryPBold,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: spacer.left.md + spacer.right.md,
                    child: TextFormField(
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: primaryPRegular,
                            fillColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            helperText: ' ',
                            errorText: _usernameError(state)),
                        controller: _usernameController),
                  ),
                  RaisedButton(
                    child: Text("Submit"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: _setUserDataAction,
                    color: Colors.white,
                    textColor: Colors.black,
                    splashColor: Colors.grey,
                  )
                ])));
          }),
    );
  }
}
