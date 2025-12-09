import 'failure.dart';

/// Unit type for representing void/empty success results
class Unit {
  const Unit();
}

const unit = Unit();

/// Result type for handling success and failure cases
/// Usage:
/// ```dart
/// Result<User> result = await repository.getUser();
/// result.when(
///   success: (user) => print('Got user: ${user.name}'),
///   failure: (error) => print('Error: ${error.message}'),
/// );
/// ```
class Result<T> {
  final T? _data;
  final Failure? _failure;

  const Result._({T? data, Failure? failure})
    : _data = data,
      _failure = failure;

  factory Result.success(T data) => Result._(data: data);
  factory Result.failure(Failure failure) => Result._(failure: failure);

  bool get isSuccess => _failure == null;
  bool get isFailure => _failure != null;

  T get data => _data!;
  Failure get failure => _failure!;

  T? get dataOrNull => _data;
  Failure? get failureOrNull => _failure;

  /// Pattern matching for handling both cases
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    if (isSuccess) {
      return success(_data as T);
    } else {
      return failure(_failure!);
    }
  }

  /// Map the success value to another type
  Result<R> map<R>(R Function(T data) transform) {
    if (isSuccess) {
      try {
        return Result.success(transform(_data as T));
      } catch (e) {
        return Result.failure(ServerFailure(e.toString()));
      }
    } else {
      return Result.failure(_failure!);
    }
  }

  /// Get data or provide a default value
  T getOrElse(T defaultValue) {
    return isSuccess ? _data as T : defaultValue;
  }

  /// Get data or execute a function that returns a default value
  T getOrElseCompute(T Function() defaultValue) {
    return isSuccess ? _data as T : defaultValue();
  }
}
