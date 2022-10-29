// Project imports:
import '../network/error_handler.dart';
import '../responses/responses.dart';

const cacheHomeKey = 'cacheHomeKey';
const cacheHomeInterval = 6000; // 1 minutes in miliseconds

abstract class LocalDataSource {
  Future<HomeResponse> getHome();

  Future<void> saveHomeToCache(HomeResponse homeResponse);
}

class LocalDataSourceImpl implements LocalDataSource {
  // runtime cache
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHome() {
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
