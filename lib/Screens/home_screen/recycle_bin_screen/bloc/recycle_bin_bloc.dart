import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recycle_bin_event.dart';
part 'recycle_bin_state.dart';

class RecycleBinBloc extends Bloc<RecycleBinEvent, RecycleBinState> {
  RecycleBinBloc() : super(RecycleBinInitial()) {
    on<RecycleBinEvent>((event, emit) {});
  }
}
