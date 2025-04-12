import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'consume_event.dart';
part 'consume_state.dart';

class ConsumeBloc extends Bloc<ConsumeEvent, ConsumeState> {
  ConsumeBloc() : super(ConsumeInitial()) {
    on<ConsumeEvent>((event, emit) {});
  }
}
