// to convert the response into a non nullable object (model)

// Project imports:
import '../../app/extensions.dart';
import '/data/responses/responses.dart';
import '/domain/model/model.dart';

const emptyString = '';
const zeroInt = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? emptyString,
      this?.name?.orEmpty() ?? emptyString,
      this?.numOfNotifications?.orZero() ?? zeroInt,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email?.orEmpty() ?? emptyString,
      this?.phone?.orEmpty() ?? emptyString,
      this?.link?.orEmpty() ?? emptyString,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer?.toDomain(),
      this?.contacts?.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? emptyString;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      id: this?.id?.orZero() ?? zeroInt,
      title: this?.title?.orEmpty() ?? emptyString,
      image: this?.image?.orEmpty() ?? emptyString,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      id: this?.id?.orZero() ?? zeroInt,
      title: this?.title?.orEmpty() ?? emptyString,
      image: this?.image?.orEmpty() ?? emptyString,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(
      id: this?.id?.orZero() ?? zeroInt,
      title: this?.title?.orEmpty() ?? emptyString,
      image: this?.image?.orEmpty() ?? emptyString,
      link: this?.link?.orEmpty() ?? emptyString,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mappedServices = (this?.data?.services?.map((service) => service.toDomain()) ?? const Iterable.empty().cast<Service>()).toList();
    List<Store> mappedStores = (this?.data?.stores?.map((store) => store.toDomain()) ?? const Iterable.empty().cast<Store>()).toList();
    List<BannerAd> mappedBanners = (this?.data?.banners?.map((banner) => banner.toDomain()) ?? const Iterable.empty().cast<BannerAd>()).toList();

    HomeData data = HomeData(
      services: mappedServices,
      stores: mappedStores,
      banners: mappedBanners,
    );
    return HomeObject(data: data);
  }
}
