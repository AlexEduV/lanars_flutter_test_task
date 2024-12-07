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
    on<ClearEmailErrors>(_onClearEmailErrors);
    on<ClearPasswordErrors>(_onClearPasswordErrors);
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

  // Clear errors handlers
  void _onClearEmailErrors(ClearEmailErrors event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;

    if (currentState.emailError != null) {
      emit(currentState.copyWith(
        emailError: null,
      ));
    }
  }

  void _onClearPasswordErrors(ClearPasswordErrors event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;

    if (currentState.passwordError != null) {
      emit(currentState.copyWith(
        passwordError: null,
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
  void _onEmailFocusChanged(
      EmailFocusChanged event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;

    //if (!event.isFocused) {
      final emailError = validateEmail(event.email);
      if (currentState.emailError != emailError) {
        emit(currentState.copyWith(emailError: emailError));
      }
    //}
  }

  // Password focus change handler
  void _onPasswordFocusChanged(
      PasswordFocusChanged event, Emitter<LoginState> emit) {
    final currentState = state as LoginInitial;

    //if (!event.isFocused) {
      final passwordError = validatePassword(event.password);
      if (currentState.passwordError != passwordError) {
        emit(currentState.copyWith(passwordError: passwordError));
      }
    //}
  }
}

