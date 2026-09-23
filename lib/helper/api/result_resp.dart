// ignore_for_file: overridden_fields

abstract class ApiResp<T> {
  String? code;
  String? message;

  ApiResp({required this.code, required this.message});
}

class SuccessResp<T> extends ApiResp<T> {
  @override
  String? code;
  @override
  String? message;
  T? data;

  SuccessResp({this.code = '', this.message = '', this.data})
    : super(code: code, message: message);

  factory SuccessResp.fromJson(Map<String, dynamic> json, T data) {
    return SuccessResp(
      code: json['code'].toString(),
      message: json['message'],
      data: data,
    );
  }
}

class ErrorResp<T> extends ApiResp<T> {
  @override
  String? code;
  @override
  String? message;

  ErrorResp({this.code = '', this.message})
    : super(code: code, message: message);

  factory ErrorResp.fromJson(Map<String, dynamic> json) {
    return ErrorResp(
      code: json['statusCode'].toString(),
      message:
          json['message'] ??
          'Koneksi bermasalah, silahkan ulangi atau coba beberapa saat lagi.',
    );
  }
}
