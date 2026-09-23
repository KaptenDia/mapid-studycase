import 'package:injectable/injectable.dart';

import '../config/di/di.dart';

final respBodyCode = getIt<RespBodyCode>();

@lazySingleton
class RespBodyCode {
  String dataDuplicated = "DUP_DATA";
  String noDataChanged = "NO_CHANGE";
  String dataAlreadyExists = "EXIST_DATA";
  String credentialMismatch = "CRED_ERROR";
  String dataTooLarge = "DATA_LARGE";
  String paymentFailed = "PAY_FAIL";
  String invalidTransaction = "INVLD_TRAN";
  String userOrDataBlocked = "BLOCKED";
  String dataRejected = "REJ_DATA";
  String expired = "EXPIRED";
  String missingKey = "MISS_KEY";
  String thirdPartyApiFailure = "EXT_API_ERR";
  String reachedMaxLimit = "MAX_LIMIT";
  String programCodeError = "PROG_ERR";
  String validationError = "ERR_INPT";
  String invalidSession = "INVLD_SESS";
  String success = "200";
}

final httpStatusCode = getIt<HttpStatusCode>();

@lazySingleton
class HttpStatusCode {
  int success = 200;
  int created = 201;
  int accepted = 202;
  int noContent = 204;
  int badRequest = 400;
  int unauthorized = 401;
  int forbidden = 403;
  int notFound = 404;
  int internalServerError = 500;
  int dataUpdated = 200;
}
