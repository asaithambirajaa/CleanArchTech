import 'package:dartz/dartz.dart';
import 'package:sarpl/core/error/failure.dart';
import 'package:sarpl/core/usecase/usecase.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';

class GetTokenUsecase extends UseCase<Map<String, dynamic>, NoParams> {
  final AuthRepository authRepository;
  GetTokenUsecase(this.authRepository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(params) async =>
      await authRepository.getToken();
}
