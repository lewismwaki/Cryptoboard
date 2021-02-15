import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sort_state.dart';

class SortCubit extends Cubit<SortState> {
  SortCubit() : super(SortInitial());

  Future<void> sortByRank() async {
    emit(SortedByRank());
  }

  Future<void> sortByMarketCap() async {
    emit(SortedByMarketCap());
  }

  Future<void> sortByPercentageChange() async {
    emit(SortedByPercentageChange());
  }

  Future<void> sortByPrice() async {
    emit(SortedByPrice());
  }

  Future<void> sortByVolume24hr() async {
    emit(SortedByVolume24hr());
  }

  Future<void> sortByMaxSupply() async {
    emit(SortedByMaxSupply());
  }

  Future<void> sortByName() async {
    emit(SortedByName());
  }
}
