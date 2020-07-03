import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/Widgets/WaveWidget.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/login/login_form.dart';
import 'package:dubs_app/screen/tutorial/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'new_user_form.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserRepository get _userRepository => widget.userRepository;
  PanelController _pc = PanelController();
  PanelController _tpc = PanelController();

  // Builds a close button
  Widget buildCloseButton(BuildContext context) {
    return IconButton(
      alignment: Alignment.topLeft,
      padding: spacer.top.lg + spacer.left.md,
      icon: Icon(Icons.close),
      color: Colors.white,
      iconSize: 28,
      onPressed: () => _pc.close(),
    );
  }

  // Builds a close button
  Widget buildTutorialCloseButton(BuildContext context) {
    return Container(
        padding: spacer.top.lg + spacer.left.md,
        child: Center(
            child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.close),
                  color: Colors.black,
                  iconSize: 22,
                  onPressed: () => _tpc.close(),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      Scaffold(
          backgroundColor: DarwinRed,
          body: Stack(
            children: [
              WaveWidget(
                size: size,
                yOffset: size.height / 1.25,
                color: const Color(0xfff2f2f2),
              ),
              SlidingUpPanel(
                  color: Color(0xFFF27D7D),
                  header: buildCloseButton(context),
                  controller: _pc,
                  backdropEnabled: true,
                  backdropColor: DarwinWhite,
                  backdropOpacity: .9,
                  backdropTapClosesPanel: true,
                  minHeight: 0,
                  maxHeight: MediaQuery.of(context).size.height,
                  panel: Container(
                    child: NewUserForm(userRepository: _userRepository),
                  ),
                  body: SlidingUpPanel(
                    header: buildTutorialCloseButton(context),
                    controller: _tpc,
                    backdropEnabled: false,
                    backdropColor: DarwinWhite,
                    backdropOpacity: .9,
                    backdropTapClosesPanel: true,
                    minHeight: 0,
                    maxHeight: MediaQuery.of(context).size.height,
                    panel: HomeView(),
                    body: Stack(
                      children: [
                        Column(
                          children: [
                            //Header Modal
                            Container(
                              height: 80.0,
                              margin:
                                  EdgeInsets.only(top: 90, left: 12, right: 12),
                              child: Stack(children: [
                                Container(
                                  padding: spacer.left.md +
                                      spacer.top.xs +
                                      spacer.bottom.none,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: spacer.top.xxs,
                                    margin: spacer.left.none,
                                    child: Text(
                                      "Login",
                                      style: primaryH1Bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  padding: spacer.top.xs + spacer.bottom.none,
                                  margin: spacer.right.md,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text('Create Account',
                                        style: darkprimaryPBold),
                                    color: Colors.white,
                                    onPressed: () => _pc.open(),
                                  ),
                                ),
                              ]),
                            ),
                            // Modal containing login form
                            Container(
                              height: 350.0,
                              margin:
                                  EdgeInsets.only(top: 0, left: 12, right: 12),
                              child: Container(
                                child:
                                    LoginForm(userRepository: _userRepository),
                              ),
                            ),

                            Container(
                                margin: spacer.top.none,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => _tpc.open(),
                                    child: Text(
                                      'Learn how Dubs works',
                                      style: uprimaryPBold,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          )),
    ]);
  }
}
