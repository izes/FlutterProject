import 'package:bloc/bloc.dart';
import '../pages/bukowski.dart';
import '../pages/shakespeare.dart';
import '../pages/homepage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  BukowskiClickedEvent,
  ShakespeareClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.BukowskiClickedEvent:
        yield Bukowski();
        break;
      case NavigationEvents.ShakespeareClickedEvent:
        yield Shakespeare();
        break;
    }
  }
}