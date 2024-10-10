import 'dart:async';

import 'package:nvvm/presentation/common/state_render/state_renderer_imp.dart';

abstract class BaseViewmodelInputs {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewmodelOutputs {
  // Có thể thêm các phương thức tại đây
  Stream<FlowState> get outputState;
}

// Lớp BaseViewmodel kế thừa từ BaseViewmodelInputs
abstract class BaseViewmodel extends BaseViewmodelInputs
    implements BaseViewmodelOutputs {
  // Thực hiện các phương thức cần thiết ở đây

  StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();


  @override
  void start() {

  }

  @override
  void dispose() {
    _inputStateStreamController.close();
  }

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState)=>flowState);



}
