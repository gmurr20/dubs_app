import 'package:dubs_app/bloc/dubs_session/session_bloc.dart';
import 'package:dubs_app/bloc/dubs_session/session_events.dart';
import 'package:dubs_app/bloc/dubs_session/session_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Score extends StatefulWidget {
  SessionBloc sessionBloc;

  Score({
    Key key,
    this.sessionBloc,
  }) : super(key: key);

  @override
  _ScoreState createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  SessionBloc get sessionBloc => widget.sessionBloc;

  final _logger = getLogger("Count");

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: sessionBloc,
        listener: (
          BuildContext context,
          SessionState state,
        ) {},
        child: BlocBuilder(
            bloc: sessionBloc,
            builder: (
              BuildContext context,
              SessionState state,
            ) {
              int count;

              if (state is CountState) {
                CountState countState = state;
                count = countState.count;
              } else if (state is TempAnimationState) {
                TempAnimationState countState = state;
                count = countState.count;
              }
              _logger.v('Print ${count}');
              return Stack(
                children: <Widget>[
                  // Adobe XD layer: 'Modal BG' (group)
                  Stack(
                    children: <Widget>[
                      // Adobe XD layer: 'Rectangle 1' (shape)
                      Container(
                        width: 349.0,
                        height: 236.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xcbf4f4f4),
                              offset: Offset(-5, -5),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 349.0,
                        height: 236.0,
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
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: Offset(244.0, 69.0),
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontFamily: 'Arial Black',
                        fontSize: 70,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(58.0, 69.0),
                    child: Text(
                      // ignore: unnecessary_brace_in_string_interps
                      "${count}",
                      style: TextStyle(
                        fontFamily: 'Arial Black',
                        fontSize: 70,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(163.0, 69.0),
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontFamily: 'Arial Black',
                        fontSize: 70,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              );
            }));
  }
}
