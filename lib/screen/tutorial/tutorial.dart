import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/bloc/tutorial/tutorial_bloc.dart';
import 'package:dubs_app/bloc/tutorial/tutorial_events.dart';
import 'package:dubs_app/bloc/tutorial/tutorial_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

class AnimatedCircle extends AnimatedWidget {
  final Tween<double> tween;
  final Tween<double> horizontalTween;
  final Animation<double> animation;
  final Animation<double> horizontalAnimation;
  final double flip;
  final Color color;

  CircleAnimationState state;

  AnimatedCircle(
      {Key key,
      @required this.animation,
      this.horizontalTween,
      this.horizontalAnimation,
      @required this.color,
      @required this.flip,
      @required this.tween,
      @required this.state})
      : assert(flip == 1 || flip == -1),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
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
            color: state.index % 2 == 0 ? Global.white : Colors.white,
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
  TutorialBloc _bloc;

  @override
  void initState() {
    _bloc = TutorialBloc();
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
        if (animationController.value > 0.5) {
          _bloc.add(HalfwayEvent(true));
        } else {
          _bloc.add(HalfwayEvent(false));
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _bloc.add(SwapColorsEvent());
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

  void _onTapGestureDetector(CircleAnimationState state) {
    if (animationController.status != AnimationStatus.forward) {
      _bloc.add(NextPageEvent());
      pageController.animateToPage(state.index,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOutQuad);
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    var image = AssetImage(
      'assets/boyphone.png',
    );

    var text = Text(
      'Invite your friends to join you on Dubs.',
      style: TextStyle(
        color: Global.white,
        fontSize: 30.0,
        fontWeight: FontWeight.w900,
      ),
      textAlign: TextAlign.center,
    );

    return BlocListener(
      bloc: _bloc,
      listener: (
        BuildContext context,
        TutorialState state,
      ) {},
      child: BlocBuilder(
          bloc: _bloc,
          builder: (
            BuildContext context,
            TutorialState state,
          ) {
            CircleAnimationState animationState;
            if (state is TempAnimationState) {
              animationState = state.state;
            } else {
              animationState = state;
            }
            return Scaffold(
              backgroundColor: animationState.isHalfWay
                  ? animationState.foreGroundColor
                  : animationState.backGroundColor,
              body: Stack(
                children: <Widget>[
                  Container(
                    color: animationState.isHalfWay
                        ? animationState.foreGroundColor
                        : animationState.backGroundColor,
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
                      onTap: () => _onTapGestureDetector(animationState),
                      child: Stack(
                        children: <Widget>[
                          AnimatedCircle(
                              animation: startAnimation,
                              color: animationState.foreGroundColor,
                              flip: 1.0,
                              tween:
                                  Tween<double>(begin: 1, end: Global.radius),
                              state: animationState),
                          AnimatedCircle(
                              animation: endAnimation,
                              color: animationState.backGroundColor,
                              flip: -1.0,
                              horizontalTween:
                                  Tween<double>(begin: 0, end: -Global.radius),
                              horizontalAnimation: horizontalAnimation,
                              tween:
                                  Tween<double>(begin: Global.radius, end: 1.0),
                              state: animationState),
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
                        if (index == 0) {
                          image = AssetImage('assets/boyphone.png');
                        } else if (index == 1) {
                          image = AssetImage('assets/toolbox.png');
                        }

                        if (index == 2) {
                          image = AssetImage('assets/redcontroller.png');
                        } else if (index == 3) {
                          image = AssetImage('assets/rocket.png');
                        }

                        if (index == 0) {
                          text = Text(
                            'Invite your friends to join you on Dubs.',
                            style: TextStyle(
                              color: Global.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          );
                          ;
                        } else if (index == 1) {
                          text = Text(
                            'Add friends to build your friend list.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          );
                        }

                        if (index == 2) {
                          text = Text(
                            'Message your squad when you want to play.',
                            style: TextStyle(
                              color: Global.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          );
                        } else if (index == 3) {
                          text = Text(
                            'Get some dubs!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          );
                        }

                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  top: 120,
                                ),
                                height: 250.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: image,
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                              Container(
                                margin: spacer.left.sm +
                                    spacer.right.sm +
                                    spacer.top.md,
                                child: text,
                              ),
                            ]);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
