sealed class CustomError {
  const CustomError();
}

class UnknownError extends CustomError {
  const UnknownError();
}

class ServerError extends CustomError {
  const ServerError();
}

class NoInternet extends CustomError {
  const NoInternet();
}
