abstract class BaseViewmodelInputs {
  void start();
  void dispose();
}

abstract class BaseViewmodelOutputs {
  // Có thể thêm các phương thức tại đây
}

// Lớp BaseViewmodel kế thừa từ BaseViewmodelInputs
abstract class BaseViewmodel extends BaseViewmodelInputs implements BaseViewmodelOutputs {
  // Thực hiện các phương thức cần thiết ở đây
}
