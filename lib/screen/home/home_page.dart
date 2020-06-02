import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

PanelController _spc = PanelController();

Widget buildCloseButton(BuildContext context) {
  return IconButton(
    alignment: Alignment.topLeft,
    icon: Icon(Icons.close),
    color: Colors.black,
    iconSize: 28,
    onPressed: () => _spc.close(),
  );
}

class _HomePageState extends State<HomePage> {
  User get _currentUser => widget.user;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: SlidingUpPanel(
            controller: _spc,
            backdropEnabled: true,
            backdropColor: DarwinWhite,
            backdropOpacity: .8,
            backdropTapClosesPanel: true,
            color: Colors.white,
            minHeight: 0,
            maxHeight: 225,
            defaultPanelState: PanelState.CLOSED,
            padding: (spacer.left.sm + spacer.top.xs),
            panel: Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: spacer.top.xs,
                  margin: spacer.left.xs + spacer.bottom.xs,
                  child: Text(
                    'Invite friends',
                    style: darkprimaryPBold,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: spacer.top.xxl,
                  margin: spacer.bottom.xs,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.blue, // button color
                          child: InkWell(
                            splashColor: Colors.grey[200], // inkwell color
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: Icon(Icons.email,
                                  semanticLabel: 'email',
                                  size: 30.0,
                                  color: DarwinWhite),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.green[500], // button color
                          child: InkWell(
                            splashColor: Colors.grey[200], // inkwell color
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: Icon(Icons.message,
                                  semanticLabel: 'messages',
                                  size: 30.0,
                                  color: DarwinWhite),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.red[500], // button color
                          child: InkWell(
                            splashColor: Colors.grey[200], // inkwell color
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: Icon(Icons.content_copy,
                                  semanticLabel: 'copy link',
                                  size: 30.0,
                                  color: DarwinWhite),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.grey, // button color
                          child: InkWell(
                            splashColor: Colors.grey[200], // inkwell color
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: Icon(Icons.more_horiz,
                                  semanticLabel: 'more options',
                                  size: 30.0,
                                  color: DarwinWhite),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: spacer.top.xs + spacer.bottom.md,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Cancel', style: primaryPBold),
                    color: DarwinRed,
                    onPressed: () => _spc.close(),
                  ),
                )
              ],
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
                            child: Text('New Message', style: primaryPBold),
                            color: DarwinRed,
                            onPressed: () {},
                          ),
                        ),
                      ]),
                    ),
                    // Modal containing 'add friends' form
                    Container(
                      height: 175.0,
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
                          child: Column(children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding: spacer.top.xxs,
                              margin: spacer.left.none,
                              child: Text(
                                "Welcome, ${_currentUser.username}",
                                style: darkprimaryH1Bold,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: spacer.top.xxs,
                              margin: spacer.left.none + spacer.right.xxs,
                              child: Text(
                                "Let’s get started by adding some of your friends.",
                                style: darkprimaryPBold,
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: spacer.bottom.xs + spacer.top.xs,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('Add Friends', style: primaryPBold),
                            color: DarwinRed,
                            onPressed: () {
                              Navigator.of(context).pushNamed(addFriendsRoute,
                                  arguments: _currentUser);
                            },
                          ),
                        ),
                      ]),
                    ),
                    // Modal containing 'invite friends' form
                    Container(
                      height: 175.0,
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
                          child: Column(children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding: spacer.top.xxs,
                              margin: spacer.left.none,
                              child: Text(
                                "Invite your squad",
                                style: darkprimaryH1Bold,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: spacer.top.xxs,
                              margin: spacer.left.none + spacer.right.xxs,
                              child: Text(
                                "You can invite your friends to Dubs via text, email, link, and social.",
                                style: darkprimaryPBold,
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: spacer.bottom.xs + spacer.top.xs,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('Invite Friends', style: primaryPBold),
                            color: DarwinRed,
                            onPressed: () => _spc.open(),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            )),
      )
    ]);
  }
}
