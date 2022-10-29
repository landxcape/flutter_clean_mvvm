// Dart imports:
import 'dart:async';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import '/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  // shared variables and functions that will be used through any view model
  final StreamController _inputStateStreamController = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init of view model
  void dispose(); // will be called when view model is removed

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
