import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_flutter_test_task/data/services/dio_client.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/custom_form_data.dart';
import 'package:lanars_flutter_test_task/domain/usecases/validate_form_usecase.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/blocs/login_events.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/blocs/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // Register event handlers
    on<LoginSubmitted>(_onLoginSubmitted);
    on<ClearErrors>(_onClearErrors);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<EmailFocusChanged>(_onEmailFocusChanged);
    on<PasswordFocusChanged>(_onPasswordFocusChanged);
  }

  // Login submission handler
  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final emailError = validateEmail(event.email);
    final passwordError = validatePassword(event.password);

    if (emailError != null || passwordError != null) {
      emit(LoginError(
        emailError: emailError ?? '',
        passwordError: passwordError ?? '',
      ));
      return;
    }

    final result = await DioClient.submitForm(
      CustomFormData(email: event.email, password: event.password).toMap(),
    );

    await DioClient.getRandomUser();

    if (GlobalMockStorage.user.firstName.isEmpty) {
      emit(LoginFailure(message: result));
    } else {
      emit(LoginSuccess());
    }
  }

  // Clear errors handler
  void _onClearErrors(ClearErrors event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }

  // Toggle password visibility handler
  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;
    emit(currentState.copyWith(
      isPasswordObscure: !currentState.isPasswordObscure,
    ));
  }

  // Email focus change handler
  void _onEmailFocusChanged(
      EmailFocusChanged event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;
    final emailError = !event.isFocused ? validateEmail(event.email) : null;

    emit(currentState.copyWith(
      isEmailFocused: event.isFocused,
      emailError: emailError,
    ));
  }

  // Password focus change handler
  void _onPasswordFocusChanged(
      PasswordFocusChanged event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;
    final passwordError = !event.isFocused ? validatePassword(event.password) : null;

    emit(currentState.copyWith(
      isPasswordFocused: event.isFocused,
      passwordError: passwordError,
    ));
  }
}

