part of 'consume_bloc.dart';

sealed class ConsumeState extends Equatable {
  const ConsumeState();
}

final class ConsumeInitial extends ConsumeState {
  @override
  List<Object> get props => [];
}
