import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sort_now_state.dart';

class SortNowCubit extends Cubit<SortNowState> {
  SortNowCubit() : super(SortNowInitial());

  Future<void> SortNowInitiate() async {
    emit(SortNowInitial());
  }

  Future<void> SortNowConclude() async {
    emit(SortNowConcluded());
  }
}
