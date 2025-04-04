class Failures {
  final String message;
  Failures(this.message);
}

class DatabaseFailure extends Failures {
  DatabaseFailure(super.message);
}
