class ApiException {
  final String _message;
  final String _prefix;

  ApiException([this._message, this._prefix]);

  String get message => _message;

  @override
  String toString() => '$_prefix$_message';
}

class BadRequestException extends ApiException {
  BadRequestException(errorResponse, [String message])
      : super(message ?? errorResponse['message'], 'Invalid Request: ');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(errorResponse, [String message])
      : super(message ?? errorResponse['message'], 'Unauthorized: ');
}

class FetchDataException extends ApiException {
  FetchDataException(errorResponse, [String message])
      : super(message ?? errorResponse['message'],
            'Error during communication: ');
}

class InvalidInputException extends ApiException {
  final errors;

  InvalidInputException(errorRespose, [String message])
      : this.errors = errorRespose['errors'],
        super(message ?? errorRespose['message'], 'Invalid Input: ');
}
