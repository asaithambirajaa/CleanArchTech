import 'package:equatable/equatable.dart';

class SendOTPPwdExpiryEntity extends Equatable {
  final SendOTPPwdExpiryResultEntity sendOTPPwdExpiryResult;

  const SendOTPPwdExpiryEntity({required this.sendOTPPwdExpiryResult});

  @override
  List<Object?> get props => [sendOTPPwdExpiryResult];
}

class SendOTPPwdExpiryResultEntity extends Equatable {
  final String errType;
  final String errMsg;
  final String pkId;
  final String oTPNo;

  const SendOTPPwdExpiryResultEntity({
    required this.errType,
    required this.errMsg,
    required this.pkId,
    required this.oTPNo,
  });

  @override
  List<Object?> get props => [
        errType,
        errMsg,
        pkId,
        oTPNo,
      ];
}
