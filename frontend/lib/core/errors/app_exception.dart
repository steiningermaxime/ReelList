sealed class AppException implements Exception {
  const AppException({required this.message});

  final String message;

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Erreur réseau. Vérifiez votre connexion internet.',
  });
}

class ServerException extends AppException {
  const ServerException({
    super.message = 'Erreur serveur. Veuillez réessayer plus tard.',
    this.statusCode,
  });

  final int? statusCode;
}

class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'La requête a expiré. Veuillez réessayer.',
  });
}

class UnexpectedException extends AppException {
  const UnexpectedException({
    super.message = 'Une erreur inattendue s\'est produite.',
  });
}

class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Ressource non trouvée.',
  });
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Non autorisé. Veuillez vous reconnecter.',
  });
}

class ValidationException extends AppException {
  const ValidationException({
    super.message = 'Données invalides.',
    this.errors,
  });

  final Map<String, dynamic>? errors;
}
