import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_flutter_test_task/data/services/dio_client.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/custom_form_data.dart';
import 'package:lanars_flutter_test_task/domain/usecases/validate_form_usecase.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/blocs/login_events.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/blocs/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield LoginLoading();

      String? emailError = validateEmail(event.email);
      String? passwordError = validateEmail(event.password);

      if (emailError != null || passwordError != null) {
        yield LoginError(
            emailError: emailError ?? '',
            passwordError: passwordError ?? ''
        );
      }
      else {
        final result = await DioClient.submitForm(
          CustomFormData(
              email: event.email,
              password: event.password,
          ).toMap(),
        );

        await DioClient.getRandomUser();
        if (GlobalMockStorage.user.firstName.isEmpty) {
          //operation is unsuccessful
          yield LoginFailure(message: result);
        }
        else {
          yield LoginSuccess();
        }
      }

      if (event is ClearErrors) {
        yield LoginInitial();
      }
    }

    if (event is TogglePasswordVisibility) {
      final currentState = state;

      if (currentState is LoginInitial) {
        yield LoginInitial(isPasswordObscure: !currentState.isPasswordObscure);
      }

    }
  }


}