part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {}

class SplashStarted extends SplashEvent {
  @override
  List<Object?> get props => [];
}
