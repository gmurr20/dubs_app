import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/Widgets/WaveWidget.dart';
import 'package:dubs_app/bloc/profile/profile_bloc.dart';
import 'package:dubs_app/bloc/profile/profile_events.dart';
import 'package:dubs_app/bloc/profile/profile_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ProfilePageInput {
  User user;
  UserRepository userRepo;

  ProfilePageInput(this.user, this.userRepo);
}

class ProfilePage extends StatefulWidget {
  ProfilePageInput input;

  ProfilePage({PageStorageKey key, @required this.input}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _bloc;

  Logger _logger = getLogger("ProfilePage");

  User get _currentUser => widget.input.user;

  UserRepository get _userRepo => widget.input.userRepo;

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
            final size = MediaQuery.of(context).size;
            return Scaffold(
                backgroundColor: DarwinRed,
                body: Stack(children: [
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: spacer.top.xxl,
                        margin:
                            spacer.left.xs + spacer.right.xs + spacer.bottom.sm,
                        child: Stack(children: [
                          Container(
                            padding: spacer.left.xs +
                                spacer.top.xs +
                                spacer.bottom.xs,
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: spacer.top.xxs,
                              margin: spacer.left.none,
                              child: Text(
                                "Profile",
                                style: primaryH1Bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: spacer.top.xs + spacer.bottom.xs,
                            margin: spacer.right.md + spacer.bottom.xs,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Logout', style: darkprimaryPBold),
                              color: Colors.white,
                              onPressed: _onLogoutPressed,
                            ),
                          ),
                          Container(
                            height: size.height / 1.5,
                            padding: spacer.top.xxl,
                            margin: spacer.top.xs,
                            child: ListView(
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      title: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: DarwinRed),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'BS',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${_currentUser.username}',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: FlatButton(
                                        padding:
                                            spacer.all.none + spacer.right.xs,
                                        color: Colors.grey[100],
                                        splashColor: Colors.greenAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        onPressed: () {},
                                        child: Wrap(
                                          // alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              alignment: Alignment.center,
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              tooltip: 'Edit',
                                              enableFeedback: true,
                                              color: Colors.grey[300],
                                              onPressed: () {},
                                            ),
                                            Text(
                                              'Edit',
                                              // textAlign: TextAlign.center,
                                              style: darkprimaryPBoldSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      contentPadding: spacer.top.xxs +
                                          spacer.bottom.xxs +
                                          spacer.left.xs +
                                          spacer.right.xxs,
                                    )),
                                Container(
                                    margin: spacer.top.xxs,
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      title: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'strumillo1@gmail.com',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: FlatButton(
                                        padding:
                                            spacer.all.none + spacer.right.xs,
                                        color: Colors.grey[100],
                                        splashColor: Colors.greenAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        onPressed: () {},
                                        child: Wrap(
                                          // alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              alignment: Alignment.center,
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              tooltip: 'Edit',
                                              enableFeedback: true,
                                              color: Colors.grey[300],
                                              onPressed: () {},
                                            ),
                                            Text(
                                              'Edit',
                                              // textAlign: TextAlign.center,
                                              style: darkprimaryPBoldSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      contentPadding: spacer.top.xxs +
                                          spacer.bottom.xxs +
                                          spacer.left.xs +
                                          spacer.right.xxs,
                                    )),
                                Container(
                                    margin: spacer.top.xxs,
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      title: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Password',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: FlatButton(
                                        padding:
                                            spacer.all.none + spacer.right.xs,
                                        color: Colors.grey[100],
                                        splashColor: Colors.greenAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        onPressed: () {},
                                        child: Wrap(
                                          // alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              alignment: Alignment.center,
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              tooltip: 'Edit',
                                              enableFeedback: true,
                                              color: Colors.grey[300],
                                              onPressed: () {},
                                            ),
                                            Text(
                                              'Edit',
                                              // textAlign: TextAlign.center,
                                              style: darkprimaryPBoldSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      contentPadding: spacer.top.xxs +
                                          spacer.bottom.xxs +
                                          spacer.left.xs +
                                          spacer.right.xxs,
                                    )),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  )
                ]));
          }),
    );
  }
}
