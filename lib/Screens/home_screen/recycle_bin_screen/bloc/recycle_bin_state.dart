part of 'recycle_bin_bloc.dart';

sealed class RecycleBinState extends Equatable {
  const RecycleBinState();
}

final class RecycleBinInitial extends RecycleBinState {
  @override
  List<Object> get props => [];
}
