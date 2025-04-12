part of 'consume_bloc.dart';

sealed class ConsumeEvent extends Equatable {
  const ConsumeEvent();
}

class ConsumeStartedEvent extends ConsumeEvent {
  const ConsumeStartedEvent();

  @override
  List<Object> get props => [];
}
