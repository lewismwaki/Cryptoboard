part of 'bottom_nav_bar_bloc.dart';

abstract class BottomNavBarEvent extends Equatable {
  const BottomNavBarEvent();
}

class LoadHomePage extends BottomNavBarEvent {
  @override
  List<Object> get props => [];
}

class LoadPricesPage extends BottomNavBarEvent {
  @override
  List<Object> get props => [];
}

class LoadDiscoverPage extends BottomNavBarEvent {
  @override
  List<Object> get props => [];
}

class LoadSettingsPage extends BottomNavBarEvent {
  @override
  List<Object> get props => [];
}
