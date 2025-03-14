import 'package:equatable/equatable.dart';

class VerifyOTPPwdExpiryEntity extends Equatable {
  final VerifyOTPPwdExpiryResultEntity verifyOTPPwdExpiryResult;

  const VerifyOTPPwdExpiryEntity({required this.verifyOTPPwdExpiryResult});

  @override
  List<Object?> get props => [verifyOTPPwdExpiryResult];
}

class VerifyOTPPwdExpiryResultEntity extends Equatable {
  final String result;

  const VerifyOTPPwdExpiryResultEntity({required this.result});

  @override
  List<Object?> get props => [result];
}
