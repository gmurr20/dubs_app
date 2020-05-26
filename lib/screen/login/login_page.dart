import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/login/login_form.dart';
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

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: SlidingUpPanel(
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
            body: Stack(
              children: [
                Column(
                  children: [
                    //Header Modal
                    Container(
                      height: 80.0,
                      margin: EdgeInsets.only(top: 40, left: 12, right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xcbf4f4f4),
                              // offset: Offset(-5, -5),
                              blurRadius: 15)
                        ],
                      ),
                      child: Stack(children: [
                        Container(
                          padding:
                              spacer.left.md + spacer.top.xs + spacer.bottom.xs,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x1a000000),
                                  offset: Offset(5, 5),
                                  blurRadius: 15)
                            ],
                          ),
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: spacer.top.xxs,
                            margin: spacer.left.none,
                            child: Text(
                              "Home",
                              style: darkprimaryH1Bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: spacer.top.xs + spacer.bottom.xs,
                          margin: spacer.right.md,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('Create Account', style: primaryPBold),
                            color: DarwinRed,
                            onPressed: () => _pc.open(),
                          ),
                        ),
                      ]),
                    ),
                    // Modal containing login form
                    Container(
                      height: 350.0,
                      margin: EdgeInsets.only(top: 10, left: 12, right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xcbf4f4f4),
                              // offset: Offset(-5, -5),
                              blurRadius: 15)
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x1a000000),
                                offset: Offset(5, 5),
                                blurRadius: 15)
                          ],
                        ),
                        child: LoginForm(userRepository: _userRepository),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    ]);
  }
}
