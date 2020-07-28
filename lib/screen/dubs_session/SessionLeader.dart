import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/bloc/dubs_session/session_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './Score.dart';
import './StepperLeft.dart';
import './StepperRight.dart';
import 'Players.dart';
import './OtherPlayers.dart';

class SessionLeader extends StatefulWidget {
  SessionLeader({
    Key key,
  }) : super(key: key);

  @override
  _SessionLeaderState createState() => _SessionLeaderState();
}

class _SessionLeaderState extends State<SessionLeader> {
  void _leavePage() {
    // _logger.v("_leavePage- entering");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: BlocProvider(
        create: (BuildContext context) => SessionBloc(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: spacer.top.xl + spacer.left.sm,
                child: IconButton(
                  alignment: Alignment.topLeft,
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  iconSize: 22,
                  onPressed: _leavePage,
                ),
              ),
              Container(
                margin: spacer.top.xs + spacer.right.xs + spacer.left.xs,
                child:
                    // Adobe XD layer: 'Players' (component)
                    Players(),
              ),
              Container(
                margin: spacer.top.xs + spacer.right.xs + spacer.left.xs,
                child:
                    // Adobe XD layer: 'Score' (component)
                    Score(),
              ),
              Container(
                  margin: spacer.top.xs + spacer.right.xs + spacer.left.xs,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      StepperLeft(),
                      StepperRight(),
                    ],
                  )
                  // Adobe XD layer: 'Stepper Left' (component)

                  ),
              Container(
                margin: spacer.top.xs + spacer.right.xs + spacer.left.xs,
                child:
                    // Adobe XD layer: 'Other Players' (component)
                    OtherPlayers(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
