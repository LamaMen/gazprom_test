import 'package:gazprom_test/core/failure.dart';

class NoSuchUserFailure extends Failure {
  const NoSuchUserFailure();
}

class WrongEmailFormatFailure extends Failure {
  const WrongEmailFormatFailure();
}

class WrongPasswordFailure extends Failure {
  const WrongPasswordFailure();
}
