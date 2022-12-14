// ignore_for_file: public_member_api_docs, sort_constructors_first
class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(
    this.title,
    this.subTitle,
    this.image,
  );
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(
    this.id,
    this.name,
    this.numOfNotifications,
  );
}

class Contacts {
  String email;
  String phone;
  String link;

  Contacts(
    this.email,
    this.phone,
    this.link,
  );
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(
    this.customer,
    this.contacts,
  );
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(
    this.name,
    this.identifier,
    this.version,
  );
}

class Service {
  int id;
  String title;
  String image;

  Service({
    required this.id,
    required this.title,
    required this.image,
  });
}

class Store {
  int id;
  String title;
  String image;

  Store({
    required this.id,
    required this.title,
    required this.image,
  });
}

class BannerAd {
  int id;
  String title;
  String image;
  String link;

  BannerAd({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
  });
}

class HomeData {
  List<Service> services;
  List<Store> stores;
  List<BannerAd> banners;

  HomeData({
    required this.services,
    required this.stores,
    required this.banners,
  });
}

class HomeObject {
  HomeData data;

  HomeObject({
    required this.data,
  });
}

class StoreDetails {
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoreDetails({
    required this.id,
    required this.title,
    required this.image,
    required this.details,
    required this.services,
    required this.about,
  });
}
