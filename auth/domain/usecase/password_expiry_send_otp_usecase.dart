import 'package:dartz/dartz.dart';
import 'package:sarpl/core/error/failure.dart';
import 'package:sarpl/core/usecase/usecase.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';

import '../entities/send_otp_pwd_expiry_entity.dart';

class PasswordExpirySendOTPUsecase
    extends UseCase<SendOTPPwdExpiryEntity, Map<String, dynamic>> {
  final AuthRepository authRepository;
  PasswordExpirySendOTPUsecase(this.authRepository);
  @override
  Future<Either<Failure, SendOTPPwdExpiryEntity>> call(
          Map<String, dynamic> params) async =>
      await authRepository.passwordExpirySendOTP(params);
}
