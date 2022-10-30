// Project imports:
import '../network/error_handler.dart';
import '../responses/responses.dart';

const cacheHomeKey = 'cacheHomeKey';
const cacheHomeInterval = 60000; // 1 minutes in miliseconds

const cacheStoreDetailsKey = 'cacheStoreDetailsKey';
const cacheStoreDetailsInterval = 60000;

abstract class LocalDataSource {
  Future<HomeResponse> getHome();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  Future<StoreDetailsResponse> getStoreDetails();

  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  // runtime cache
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];

    if (cachedItem != null && cachedItem.isValid(cacheHomeInterval)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
    CachedItem? cachedItem = cacheMap[cacheStoreDetailsKey];

    if (cachedItem != null && cachedItem.isValid(cacheStoreDetailsInterval)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response) async {
    cacheMap[cacheHomeKey] = CachedItem(response);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMs = DateTime.now().millisecondsSinceEpoch;

    bool isCachedValid = currentTimeInMs - expirationTime < cacheTime;

    return isCachedValid;
  }
}
