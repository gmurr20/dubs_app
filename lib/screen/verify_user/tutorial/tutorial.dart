import 'dart:ffi';

import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/screen/verify_user/tutorial/tutorial_bloc.dart';
import 'package:dubs_app/screen/verify_user/tutorial/tutorial_events.dart';
import 'package:dubs_app/screen/verify_user/tutorial/tutorial_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

class AnimatedCircle extends AnimatedWidget {
  final Tween<double> tween;
  final Tween<double> horizontalTween;
  final Animation<double> animation;
  final Animation<double> horizontalAnimation;
  final double flip;
  final Color color;

  AnimatedCircle({
    Key key,
    @required this.animation,
    this.horizontalTween,
    this.horizontalAnimation,
    @required this.color,
    @required this.flip,
    @required this.tween,
  })  : assert(flip == 1 || flip == -1),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final bloc = CircleAnimationState();

    return Transform(
      alignment: FractionalOffset.centerLeft,
      transform: Matrix4.identity()
        ..scale(
          tween.evaluate(animation) * flip,
          tween.evaluate(animation),
        ),
      child: Transform(
        transform: Matrix4.identity()
          ..translate(
            horizontalTween != null
                ? horizontalTween.evaluate(horizontalAnimation)
                : 0.0,
          ),
        child: Container(
          width: Global.radius,
          height: Global.radius,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              Global.radius / 2.0 -
                  tween.evaluate(animation) / (Global.radius / 2.0),
            ),
          ),
          child: Icon(
            flip == 1 ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,
            color: bloc.index % 2 == 0 ? Global.white : Global.mediumBlue,
          ),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation startAnimation;
  Animation endAnimation;
  Animation horizontalAnimation;
  PageController pageController;
  CircleAnimationBloc _bloc;

  @override
  void initState() {
    _bloc = CircleAnimationBloc();
    super.initState();

    pageController = PageController();
    animationController =
        AnimationController(duration: Duration(milliseconds: 750), vsync: this);

    startAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.000, 0.500, curve: Curves.easeInExpo),
    );

    endAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.500, 1.000, curve: Curves.easeOutExpo),
    );

    horizontalAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.750, 1.000, curve: Curves.easeInOutQuad),
    );

    animationController
      ..addListener(() {
        final bloc = CircleAnimationState();
        if (animationController.value > 0.5) {
          bloc.isHalfWay = true;
        } else {
          bloc.isHalfWay = false;
        }
      })
      ..addStatusListener((status) {
        final bloc = CircleAnimationState();
        if (status == AnimationStatus.completed) {
          bloc.swapColors();
          animationController.reset();
        }
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = CircleAnimationState();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocListener(
      bloc: _bloc,
      listener: (
        BuildContext context,
        CircleAnimation state,
      ) {},
      child: Scaffold(
        backgroundColor:
            bloc.isHalfWay ? bloc.foreGroundColor : bloc.backGroundColor,
        body: Stack(
          children: <Widget>[
            Container(
              color:
                  bloc.isHalfWay ? bloc.foreGroundColor : bloc.backGroundColor,
              width: screenWidth / 2.0 - Global.radius / 2.0,
              height: double.infinity,
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  screenWidth / 2 - Global.radius / 2.0,
                  screenHeight - Global.radius - Global.bottomPadding,
                ),
              child: GestureDetector(
                onTap: () {
                  if (animationController.status != AnimationStatus.forward) {
                    bloc.isToggled = !bloc.isToggled;
                    bloc.index++;
                    if (bloc.index > 3) {
                      bloc.index = 0;
                    }
                    pageController.animateToPage(bloc.index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOutQuad);
                    animationController.forward();
                  }
                },
                child: Stack(
                  children: <Widget>[
                    AnimatedCircle(
                      animation: startAnimation,
                      color: bloc.foreGroundColor,
                      flip: 1.0,
                      tween: Tween<double>(begin: 1, end: Global.radius),
                    ),
                    AnimatedCircle(
                      animation: endAnimation,
                      color: bloc.backGroundColor,
                      flip: -1.0,
                      horizontalTween:
                          Tween<double>(begin: 0, end: -Global.radius),
                      horizontalAnimation: horizontalAnimation,
                      tween: Tween<double>(begin: Global.radius, end: 1.0),
                    ),
                  ],
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: PageView.builder(
                controller: pageController,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      'Page ${index + 1}',
                      style: TextStyle(
                        color:
                            index % 2 == 0 ? Global.mediumBlue : Global.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
