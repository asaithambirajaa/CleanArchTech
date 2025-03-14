import 'package:dartz/dartz.dart';
import 'package:sarpl/core/error/failure.dart';
import 'package:sarpl/core/usecase/usecase.dart';
import 'package:sarpl/features/auth/domain/entities/login_entity.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';

class LoginServiceUsecase
    extends UseCase<DoLoginSessionIDNewResultEntity, Map<String, dynamic>> {
  final AuthRepository authRepository;
  LoginServiceUsecase(this.authRepository);
  @override
  Future<Either<Failure, DoLoginSessionIDNewResultEntity>> call(
          Map<String, dynamic> params) async =>
      await authRepository.loginService(params);
}
