import 'package:nvvm/app/extension.dart';
import 'package:nvvm/data/responses/responses.dart';
import 'package:nvvm/presentation/domain/model.dart';

extension CustomerResponseMapper on CustomerResponse {
  Customer toCustomerDomain() {
    return Customer(this?.id?.orEmpty() ?? EMPTY, this.name?.orEmpty() ?? EMPTY,
        this.numOfNotifications.orZero() ?? ZERO);
  }
}

extension ContactResponseMapper on ContactResponse {
  Contacts toContactDomain() {
    return Contacts(this?.email?.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationsResponse {
  Authentication toAuthenticationDomain() {
    return Authentication(this?.customer?.toCustomerDomain(),
        this?.contacts?.toContactDomain());
  }
}
