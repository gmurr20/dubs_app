import 'package:dubs_app/bloc/dubs_session/session_bloc.dart';
import 'package:dubs_app/bloc/dubs_session/session_events.dart';
import 'package:dubs_app/bloc/dubs_session/session_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepperLeft extends StatefulWidget {
  StepperLeft({
    Key key,
  }) : super(key: key);

  @override
  _StepperLeftState createState() => _StepperLeftState();
}

class _StepperLeftState extends State<StepperLeft> {
  @override
  Widget build(BuildContext context) {
    final _sessionBloc = SessionBloc();
    _sessionBloc.listen(print);

    return BlocListener(
        bloc: _sessionBloc,
        listener: (
          BuildContext context,
          SessionState state,
        ) {},
        child: BlocBuilder(
            bloc: _sessionBloc,
            builder: (
              BuildContext context,
              SessionState state,
            ) {
              CountState countState;
              if (state is TempAnimationState) {
                countState = state.state;
              } else {
                countState = state;
              }
              return Container(
                width: 143.0,
                height: 59.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1a000000),
                      offset: Offset(5, 5),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            splashColor: Colors.greenAccent,
                            child: Icon(
                              Icons.expand_less,
                              color: Colors.black,
                              size: 36,
                            ),
                            onTap: () {
                              _sessionBloc.add(IncrementWinEvent());
                            },
                          )),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          splashColor: Colors.redAccent,
                          child: Icon(
                            Icons.expand_more,
                            color: Colors.black,
                            size: 36,
                          ),
                          onTap: () {
                            _sessionBloc.add(DecrementWinEvent());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
