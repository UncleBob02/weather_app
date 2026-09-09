abstract class Failure {
  final String message;

  const Failure(this.message);
}

class LocationFailure extends Failure {
  const LocationFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}