import 'package:bloc/bloc.dart';
import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/bloc/verify_user/tutorial/tutorial_events.dart';
import 'package:dubs_app/bloc/verify_user/tutorial/tutorial_states.dart';

class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  CircleAnimationState currentState = CircleAnimationState(
      0, false, false, Global.palette[0], Global.palette[1]);

  @override
  TutorialState get initialState => CircleAnimationState(
      0, false, false, Global.palette[0], Global.palette[1]);

  @override
  Stream<TutorialState> mapEventToState(TutorialEvent event) async* {
    if (event is IsToggledEvent) {
      yield* mapIsToggledEvent(event);
    } else if (event is HalfwayEvent) {
      yield* mapHalfwayEvent(event);
    } else if (event is SwapColorsEvent) {
      yield* mapSwapColorsEvent(event);
    } else if (event is NextPageEvent) {
      yield* mapNextPageEvent(event);
    }
  }

  Stream<TutorialState> mapIsToggledEvent(IsToggledEvent event) async* {
    yield TempAnimationState(currentState);
    currentState.isToggled = !currentState.isToggled;
    yield currentState;
  }

  Stream<TutorialState> mapHalfwayEvent(HalfwayEvent event) async* {
    if (currentState.isHalfWay == event.isHalfway) {
      return;
    }
    yield TempAnimationState(currentState);
    currentState.isHalfWay = event.isHalfway;
    yield currentState;
  }

  Stream<TutorialState> mapSwapColorsEvent(SwapColorsEvent event) async* {
    yield TempAnimationState(currentState);
    if (currentState.isToggled) {
      currentState.backGroundColor = Global.palette[1];
      currentState.foreGroundColor = Global.palette[0];
    } else {
      currentState.backGroundColor = Global.palette[0];
      currentState.foreGroundColor = Global.palette[1];
    }
    yield currentState;
  }

  Stream<TutorialState> mapNextPageEvent(NextPageEvent event) async* {
    yield TempAnimationState(currentState);
    currentState.isToggled = !currentState.isToggled;
    currentState.index++;
    if (currentState.index > 3) {
      currentState.index = 0;
    }
    yield currentState;
  }
}
