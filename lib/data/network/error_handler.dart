enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
}

class ResponseCode {
  // API status codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unauthorised = 401; // user is not authorized
  static const int notFound = 404; // failure, api url incorrect, not found
  static const int internalServerError = 500; // failure, crash happened in server side

  // local status codes
  static const int unknown = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status codes
  static const String success = 'success'; // success with data
  static const String noContent = 'success with no content'; // success with no content
  static const String badRequest = 'bad request, try again later'; // failure, api rejected the request
  static const String forbidden = 'forbidden request, try again later'; // failure, api rejected the request
  static const String unauthorised = 'user is unauthorized, try again later'; // user is not authorized
  static const String notFound = 'Url is not found, try again later'; // failure, api url incorrect, not found
  static const String internalServerError = 'something is wrong, try again later'; // failure, crash happened in server side

  // local status codes
  static const String unknown = 'something is wrong, try again later';
  static const String connectTimeout = 'time out error, try again later';
  static const String cancel = 'request was cancelled, try again later';
  static const String receiveTimeout = 'time out error, try again later';
  static const String sendTimeout = 'time out error, try again later';
  static const String cacheError = 'cache error, try again later';
  static const String noInternetConnection = 'Please check your internet connection';
}
