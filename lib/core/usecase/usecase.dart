import 'package:fpdart/fpdart.dart';

import '../error/fail.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Fail, SuccessType>> call(Params params);
}

class NoParams {}
