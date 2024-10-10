import 'package:nvvm/data/network/error_handler.dart';
import 'package:nvvm/presentation/onboardiing/onboarding.dart';

class SlideViewObject {
  SlideViewObject(this.sliderObject, this.numOfSliders, this.currentIndex);

  SliderObject sliderObject;
  int numOfSliders;

  int currentIndex;
}

class SliderObject {
  SliderObject(this.title, this.subTitle, this.image);

  String title;
  String subTitle;
  String image;
}

class Authentication {
  Authentication(this.customer, this.contacts);

  Customer? customer;
  Contacts? contacts;
}

class Contacts {
  Contacts(this.email, this.phone, this.link);

  String? email;
  String? phone;
  String? link;
}

class Customer {
  Customer(this.id, this.name, this.numOfNotifications);

  String? id;
  String? name;
  int? numOfNotifications;
}

class Failure {
  int code;
  String message;
  Failure(this.code, this.message);
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}



class DeviceInfo {
  DeviceInfo(this.nameDevice, this.indentifier, this.version);
  String nameDevice;
  String indentifier;
  String version;
}
