import 'package:dartz/dartz.dart';
import 'package:sarpl/core/error/failure.dart';
import 'package:sarpl/core/usecase/usecase.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';

import '../entities/verify_otp_pwd_expiry.dart';

class PasswordExpiryVerifyOTPUsecase
    extends UseCase<VerifyOTPPwdExpiryEntity, Map<String, dynamic>> {
  final AuthRepository authRepository;
  PasswordExpiryVerifyOTPUsecase(this.authRepository);
  @override
  Future<Either<Failure, VerifyOTPPwdExpiryEntity>> call(
          Map<String, dynamic> params) async =>
      await authRepository.passwordExpiryVerifyOTP(params);
}
