import 'package:dartz/dartz.dart';
import 'package:sarpl/core/error/failure.dart';
import 'package:sarpl/core/usecase/usecase.dart';
import 'package:sarpl/features/auth/domain/entities/complete_signup_entity.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';

class VerifyCodeUsecase
    extends UseCase<CompleteSignUpEntity, Map<String, dynamic>> {
  final AuthRepository authRepository;
  VerifyCodeUsecase(this.authRepository);
  @override
  Future<Either<Failure, CompleteSignUpEntity>> call(
          Map<String, dynamic> params) async =>
      authRepository.verifyCode(params);
}
