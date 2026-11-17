import 'package:firebase_auth/firebase_auth.dart';

String authErrorMessage(FirebaseAuthException error) {
  return switch (error.code) {
    'invalid-email' => 'El correo electrónico no es válido.',
    'invalid-credential' ||
    'user-not-found' ||
    'wrong-password' => 'El correo o la contraseña son incorrectos.',
    'email-already-in-use' => 'Ya existe una cuenta con este correo.',
    'weak-password' => 'La contraseña es demasiado débil.',
    'user-disabled' => 'Esta cuenta ha sido deshabilitada.',
    'too-many-requests' =>
      'Se realizaron demasiados intentos. Inténtalo más tarde.',
    'network-request-failed' =>
      'No se pudo conectar. Revisa tu conexión a internet.',
    _ => 'Ocurrió un error de autenticación. Inténtalo de nuevo.',
  };
}
