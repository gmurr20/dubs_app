import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'new_user_form.dart';

// comment to test shit
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

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: SlidingUpPanel(
            color: Color(0xFF162A49),
            backdropEnabled: true,
            backdropColor: DarwinWhite,
            backdropOpacity: .9,
            backdropTapClosesPanel: true,
            minHeight: 100,
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
                              offset: Offset(-5, -5),
                              blurRadius: 15)
                        ],
                      ),
                      child: Container(
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
                              offset: Offset(-5, -5),
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
