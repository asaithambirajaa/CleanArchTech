class ErrorModel {
  final String errType;
  final String errMsg;

  ErrorModel({required this.errType, required this.errMsg});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      errType: json['ErrType'],
      errMsg: json['ErrMsg'],
    );
  }
}
