import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateUserPage extends StatefulWidget {
  final UserRepository userRepository;

  CreateUserPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _CreateUserPage createState() => _CreateUserPage();
}

class _CreateUserPage extends State<CreateUserPage> {
  // LoginBloc _loginBloc;

  UserRepository get _userRepository => widget.userRepository;

  // @override
  // void initState() {
  //   _loginBloc = LoginBloc(userRepo: _userRepository);
  //   _loginBloc.add(AppStartEvent());
  // }

  // @override
  // void dispose() {
  //   _loginBloc.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Login'),
    ));
  }
}
