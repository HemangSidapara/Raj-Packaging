part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();
}

class SignInStartedEvent extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class SignInLoadingEvent extends SignInEvent {
  final bool isLoading;

  const SignInLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class SignInClickedEvent extends SignInEvent {
  final String phoneNumber;
  final String password;
  final bool isValidate;

  const SignInClickedEvent({
    required this.phoneNumber,
    required this.password,
    required this.isValidate,
  });

  @override
  List<Object?> get props => [phoneNumber, password];
}

class SignInPasswordVisibilityEvent extends SignInEvent {
  final bool isPasswordVisible;

  const SignInPasswordVisibilityEvent({
    required this.isPasswordVisible,
  });

  @override
  List<Object?> get props => [isPasswordVisible];
}

class SignInSuccessEvent extends SignInEvent {
  final LoginModel loginModel;

  const SignInSuccessEvent({required this.loginModel});

  @override
  List<Object?> get props => [loginModel];
}

class SignInFailedEvent extends SignInEvent {
  @override
  List<Object?> get props => [];
}
