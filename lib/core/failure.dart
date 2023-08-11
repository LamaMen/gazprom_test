import 'package:flutter/foundation.dart';

@immutable
abstract class Failure {
  const Failure();
}

class UnknownFailure extends Failure {
  const UnknownFailure();
}

class InternetFailure extends Failure {
  const InternetFailure();
}

