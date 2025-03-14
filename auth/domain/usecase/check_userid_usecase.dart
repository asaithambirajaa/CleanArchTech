import 'package:dartz/dartz.dart';
import 'package:sarpl/core/error/failure.dart';
import 'package:sarpl/core/usecase/usecase.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';

class CheckUserIdUsecase extends UseCase<Map<String, dynamic>, String> {
  final AuthRepository authRepository;
  CheckUserIdUsecase(this.authRepository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(String params) async =>
     await authRepository.checkUserId(params);
}
