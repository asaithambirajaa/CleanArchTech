import 'package:dartz/dartz.dart';
import 'package:sarpl/core/error/failure.dart';
import 'package:sarpl/core/usecase/usecase.dart';
import 'package:sarpl/features/auth/domain/repositories/auth_repository.dart';

class ChangePasswordUsecase
    extends UseCase<Map<String, dynamic>, Map<String, dynamic>> {
  final AuthRepository repository;
  ChangePasswordUsecase(this.repository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
          Map<String, dynamic> params) async =>
      await repository.changePassword(params);
}
