import 'package:gazprom_test/core/failure.dart';

abstract class Result<S> {
  const Result();

  bool get isError => this is Error<S>;

  bool get isSuccess => this is Success<S>;

  Failure get failure => this.fold(
      (value) => value,
      (_) => throw Exception(
          'Illegal use. You should check isError before calling'));

  S get value => this.fold<S>(
      (_) => throw Exception(
          'Illegal use. You should check isSuccess before calling'),
      (value) => value);

  T fold<T>(T Function(Failure failure) fnE, T Function(S value) fnS);

  @override
  bool operator ==(Object other) {
    return this.fold(
      (left) => other is Error && left == other._value,
      (right) => other is Success && right == other._value,
    );
  }

  @override
  int get hashCode => fold((e) => e.hashCode, (s) => s.hashCode);
}

class Error<S> extends Result<S> {
  const Error(this._value);

  final Failure _value;

  @override
  T fold<T>(T Function(Failure failure) fnE, T Function(S value) fnS) {
    return fnE(_value);
  }
}

class Success<S> extends Result<S> {
  const Success(this._value);

  final S _value;

  @override
  T fold<T>(T Function(Failure failure) fnE, T Function(S value) fnS) {
    return fnS(_value);
  }
}

extension FailureWrapper on Failure {
  Result get asError => Error(this);
}
