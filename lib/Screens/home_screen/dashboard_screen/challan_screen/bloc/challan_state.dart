part of 'challan_bloc.dart';

sealed class ChallanState extends Equatable {
  const ChallanState();
}

final class ChallanInitial extends ChallanState {
  @override
  List<Object> get props => [];
}
