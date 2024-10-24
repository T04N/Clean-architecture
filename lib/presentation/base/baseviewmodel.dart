import 'dart:async';
import '../common/state_renderer/state_render_impl.dart';

class BaseViewModel implements BaseViewModelInputs, BaseViewModelOutputs {
  StreamController<FlowState> _inputStateStreamController = StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }

  // This method will be implemented in child classes
  @override
  void start() {
    // Implementation for start can be provided by subclasses or here directly
  }

// shared variables and functions that will be used through any view model.
}

abstract class BaseViewModelInputs {
  void start(); // will be called during initialization of the view model
  void dispose(); // will be called when the viewmodel is disposed.

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
