import 'package:flutter_training_app/models/redux/redux_models.dart';
import 'package:flutter_training_app/reducers/test_reducers.dart';

AppState appReducer(AppState state, action) {
    return AppState(
        reduxSetup: testReducer(state.reduxSetup, action),
    );
}