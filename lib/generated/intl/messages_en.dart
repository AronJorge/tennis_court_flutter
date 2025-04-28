// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "emailLabel": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "emptyFields": MessageLookupByLibrary.simpleMessage(
      "Por favor completa todos los campos.",
    ),
    "errorLogin": MessageLookupByLibrary.simpleMessage(
      "Error al iniciar sesión.",
    ),
    "errorRegister": MessageLookupByLibrary.simpleMessage(
      "Error al registrar la cuenta.",
    ),
    "failedToLoadCourts": MessageLookupByLibrary.simpleMessage(
      "Error al cargar las canchas",
    ),
    "failedToLoadReservations": MessageLookupByLibrary.simpleMessage(
      "Error al cargar las reservas",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "¿Olvidaste tu contraseña?",
    ),
    "invalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Credenciales inválidas",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Por favor ingresa un email válido.",
    ),
    "loginButton": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "noAccount": MessageLookupByLibrary.simpleMessage("¿Aún no tienes cuenta?"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Las contraseñas no coinciden.",
    ),
    "registerButton": MessageLookupByLibrary.simpleMessage("Regístrate"),
    "rememberPassword": MessageLookupByLibrary.simpleMessage(
      "Recordar contraseña",
    ),
    "unknownError": MessageLookupByLibrary.simpleMessage("Error desconocido."),
    "userNotFound": MessageLookupByLibrary.simpleMessage(
      "Usuario no encontrado",
    ),
  };
}
