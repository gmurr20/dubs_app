import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/bloc/profile/profile_bloc.dart';
import 'package:dubs_app/bloc/profile/profile_events.dart';
import 'package:dubs_app/bloc/profile/profile_states.dart';
import 'package:dubs_app/common/navigation.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final UserRepository userRepo;

  ProfilePage({Key key, @required this.userRepo, @required this.user})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _bloc;

  Logger _logger = getLogger("ProfilePage");

  User get _currentUser => widget.user;

  UserRepository get _userRepo => widget.userRepo;

  @override
  void initState() {
    _bloc = ProfileBloc(userRepo: _userRepo, user: _currentUser);
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onLogoutPressed() {
    _bloc.add(ProfileLogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (
        BuildContext context,
        ProfileState state,
      ) {
        if (state is ProfileLoggedOutState) {
          _logger.v("listener- logging out");
          Navigator.of(context).pushNamed(loginRoute);
        }
      },
      child: BlocBuilder(
          bloc: _bloc,
          builder: (
            BuildContext context,
            ProfileState state,
          ) {
            return Scaffold(
              backgroundColor: const Color(0xfff2f2f2),
              bottomNavigationBar: NavigationHelper.buildBottomNav(
                  NavigationPageResult.PROFILE, context, _currentUser),
              body: Container(
                alignment: Alignment.bottomCenter,
                padding: spacer.bottom.xs + spacer.top.xs,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Logout', style: primaryPBold),
                  color: DarwinRed,
                  onPressed: _onLogoutPressed,
                ),
              ),
            );
          }),
    );
  }
}
