import 'package:dartz/dartz.dart';
import 'package:sarpl/core/error/failure.dart';
import 'package:sarpl/core/usecase/usecase.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';

class GetVerificationCodeUsecase
    extends UseCase<Map<String, dynamic>, Map<String, dynamic>> {
  final AuthRepository authRepository;

  GetVerificationCodeUsecase(this.authRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
          Map<String, dynamic> params) async =>
      await authRepository.getVerificationCode(params);
}
