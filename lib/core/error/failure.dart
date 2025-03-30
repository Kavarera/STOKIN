class Failure {
  final String message;

  Failure(this.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required String message}) : super(message);
}
