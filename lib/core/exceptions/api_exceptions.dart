class ApiException {
  final String _message;
  final String _prefix;

  ApiException([this._message, this._prefix]);

  String get message => _message;

  @override
  String toString() => '$_prefix$_message';
}

class BadRequestException extends ApiException {
  BadRequestException([String message]) : super(message, 'Invalid Request: ');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String message]) : super(message, 'Unauthorized: ');
}

class ResourceNotFoundException extends ApiException {
  ResourceNotFoundException([String message])
      : super(message, 'Resource Not Found: ');
}

class FetchDataException extends ApiException {
  FetchDataException([String message])
      : super(message, 'Error during communication: ');
}

class InvalidInputException extends ApiException {
  final errors;

  InvalidInputException(errors, [String message])
      : this.errors = errors,
        super(message, 'Invalid Input: ');
}
