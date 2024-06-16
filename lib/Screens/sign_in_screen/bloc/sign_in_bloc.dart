import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/auth_models/login_model.dart';
import 'package:raj_packaging/Network/services/auth_services/auth_services.dart';
import 'package:raj_packaging/generated/l10n.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInStartedEvent>((event, emit) {});

    on<SignInPasswordVisibilityEvent>((event, emit) {
      emit(SignInPasswordVisibilityState(isPasswordVisible: event.isPasswordVisible));
    });

    on<SignInClickedEvent>((event, emit) async {
      await checkSignIn(event, emit);
    });

    on<SignInLoadingEvent>((event, emit) async {
      emit(SignInLoadingState(isLoading: event.isLoading));
    });

    on<SignInSuccessEvent>((event, emit) async {
      setData(AppConstance.authorizationToken, event.loginModel.token);
      emit(SignInSuccessState(loginModel: event.loginModel));
    });

    on<SignInFailedEvent>((event, emit) async {
      emit(SignInFailedState());
    });
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterPhoneNumber;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterPassword;
    }
    return null;
  }

  Future<void> checkSignIn(SignInClickedEvent event, Emitter<SignInState> emit) async {
    try {
      add(const SignInLoadingEvent(isLoading: true));
      if (event.isValidate) {
        final response = await AuthServices.loginService(phone: event.phoneNumber, password: event.password);

        if (response.isSuccess) {
          add(SignInSuccessEvent(loginModel: LoginModel.fromJson(response.response?.data)));
        } else {
          add(SignInFailedEvent());
        }
      }
    } finally {
      add(const SignInLoadingEvent(isLoading: false));
    }
  }
}
