part of 'bottom_nav_bar_bloc.dart';

abstract class BottomNavBarState extends Equatable {
  const BottomNavBarState();
}

class LoadedHomePage extends BottomNavBarState {
  final String title = 'red';
  final int index = 0;
  @override
  List<Object> get props => [title, index];
}

class LoadedPricesPage extends BottomNavBarState {
  final String title = 'green';
  final int index = 1;
  @override
  List<Object> get props => [title, index];
}

class LoadedDiscoverPage extends BottomNavBarState {
  final String title = 'blue';
  final int index = 2;
  @override
  List<Object> get props => [title, index];
}

class LoadedSettingsPage extends BottomNavBarState {
  final String title = 'yellow';
  final int index = 3;
  @override
  List<Object> get props => [title, index];
}
