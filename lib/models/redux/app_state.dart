import 'package:meta/meta.dart';

// Response Model
import 'package:flutter_training_app/response_model/loginResponse.dart';

@immutable
class AppState{
    final bool reduxSetup;
    final LoginAPIResponse loginAPIResponse;
    const AppState({
        @required this.reduxSetup,
        @required this.loginAPIResponse
    });
}