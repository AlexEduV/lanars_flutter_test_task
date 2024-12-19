import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_flutter_test_task/data/network/dio_client.dart';
import 'package:lanars_flutter_test_task/data/repositories/login_repository_impl.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/custom_form_data.dart';
import 'package:lanars_flutter_test_task/domain/usecases/validate_form_usecase.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/blocs/login_events.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/blocs/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // Register event handlers
    on<LoginSubmitted>(_onLoginSubmitted);
    on<ClearEmailErrors>(_onClearEmailErrors);
    on<ClearPasswordErrors>(_onClearPasswordErrors);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
  }

  // Login submission handler
  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {

    debugPrint('login submitted');

    final emailError = EmailValidator().validate(event.email);
    final passwordError = PasswordValidator().validate(event.password);

    if (emailError != null || passwordError != null) {
      emit(
          LoginInitial(
            emailError: emailError,
            passwordError: passwordError,
          )
      );
      return;
    }

    emit(LoginLoading());



    final result = await LoginRepositoryImpl().submitForm(
      DioClient.client,
      CustomFormData(email: event.email, password: event.password)
          .toMap(),
    );

    await LoginRepositoryImpl().getRandomUser(DioClient.client);

    if (GlobalMockStorage.user.firstName.isEmpty) {
      emit(LoginFailure(message: result));
    } else {
      emit(LoginSuccess());
    }
  }

  // Clear errors handlers
  void _onClearEmailErrors(ClearEmailErrors event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;

    if (currentState.emailError != null) {
      emit(currentState.copyWith(
        emailError: '',
      ));
    }
  }

  void _onClearPasswordErrors(ClearPasswordErrors event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;

    if (currentState.passwordError != null) {
      emit(currentState.copyWith(
        passwordError: '',
      ));
    }
  }

  // Toggle password visibility handler
  void _onTogglePasswordVisibility(TogglePasswordVisibility event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;
    emit(currentState.copyWith(
      isPasswordObscure: !currentState.isPasswordObscure,
    ));
  }

  // Email focus change handler
  void _onEmailUnfocused(
      EmailUnfocused event, Emitter<LoginState> emit) {
    if (state is !LoginInitial) return;

    final currentState = state as LoginInitial;

    final emailError = EmailValidator().validate(event.email);
    if (currentState.emailError != emailError) {
      emit(currentState.copyWith(emailError: emailError));
    }
  }

  // Password focus change handler
  void _onPasswordUnfocused(
      PasswordUnfocused event, Emitter<LoginState> emit) {
    if (state is !LoginInitial) return;

    final currentState = state as LoginInitial;

    final passwordError = PasswordValidator().validate(event.password);
    if (currentState.passwordError != passwordError) {
      emit(currentState.copyWith(passwordError: passwordError));
    }

  }
}

