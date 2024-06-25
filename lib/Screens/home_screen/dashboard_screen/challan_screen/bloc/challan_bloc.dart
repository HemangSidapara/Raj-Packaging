import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'challan_event.dart';
part 'challan_state.dart';

class ChallanBloc extends Bloc<ChallanEvent, ChallanState> {
  ChallanBloc() : super(ChallanInitial()) {
    on<ChallanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
