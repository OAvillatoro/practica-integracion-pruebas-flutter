# Práctica de integración y pruebas — Flutter

Aplicación Flutter Web en español con autenticación por correo y gestión personal de tareas. Usa Firebase Authentication y Cloud Firestore; no usa FCM, Storage ni APIs REST externas.

## Información académica

**Universidad:** Universidad Tecnológica de El Salvador (UTEC)  
**Asignatura:** Técnicas de Calidad de Software  
**Actividad:** E4_A1 — Práctica de laboratorio: Integración y pruebas funcionales del proyecto  
**Modalidad:** Trabajo en pareja

### Integrantes

| Nombre completo | Carnet | Usuario de GitHub |
|---|---|---|
| Oscar Villatoro | 2942862018 | [OAvillatoro](https://github.com/OAvillatoro) |
| Alan Isai Reyes Ramirez | 2937542022 | [alanrey777-rgb](https://github.com/alanrey777-rgb) |

## Funciones

- Registro, inicio, persistencia y cierre de sesión.
- Tareas privadas por usuario en `users/{userId}/tasks/{taskId}`.
- Creación, edición, cambio pendiente/completada y eliminación con confirmación.
- Estados de carga, error y lista vacía.
- Prueba widget aislada de Firebase y prueba unitaria del modelo de tarea.

## Requisitos

- Flutter `3.50.0` con Dart `3.14.0`.
- Chromium o Chrome disponible para Flutter Web.
- Un proyecto Firebase con Authentication por correo/contraseña y Cloud Firestore habilitados.
- FlutterFire CLI sólo si se necesita regenerar la configuración para otro proyecto.

## Instalación

```bash
git clone https://github.com/OAvillatoro/practica-integracion-pruebas-flutter
cd practica-integracion-pruebas-flutter
git checkout semana16-integracion
flutter pub get
flutter config --enable-web
```

## Configuración Firebase

El repositorio usa `lib/firebase_options.dart`, generado con FlutterFire para el proyecto del curso. Para configurar una instancia propia, iniciar sesión con las herramientas de Firebase y ejecutar:

```bash
flutterfire configure
```

Después se debe habilitar el proveedor **Email/Password**, crear Cloud Firestore y publicar `firestore.rules`. No se deben copiar al repositorio credenciales privadas, cuentas de servicio ni contraseñas. La configuración web de Firebase identifica el proyecto, pero no sustituye las reglas de seguridad.

## Ejecución Web

```bash
flutter run -d chrome
```

También puede elegirse un dispositivo Chromium listado por:

```bash
flutter devices
flutter run -d <ID_DISPOSITIVO>
```

Para generar una compilación de producción:

```bash
flutter build web
```

## Calidad y pruebas

```bash
flutter analyze
flutter test
```

El último registro guardado indica análisis sin incidencias y dos pruebas aprobadas: [análisis](docs/evidencias/pruebas-y-analisis/flutter-analyze-final.txt) y [pruebas](docs/evidencias/pruebas-y-analisis/flutter-test-final.txt).

## Documentación y evidencia

- [Declaración de alcance](docs/01-declaracion-alcance.md)
- [Mapa de flujos críticos](docs/02-mapa-flujos-criticos.md)
- [Casos de prueba](docs/03-plantilla-pruebas.md)
- [Registro de incidencias](docs/04-registro-incidencias.md)
- [Reflexión final](docs/05-reflexion-final.md)
- [Evidencias](docs/evidencias/)

## Historial relevante

| Commit | Cambio |
|---|---|
| `e714680` | Proyecto Flutter inicial. |
| `6e60685` | Corrección de INC-001 y prueba widget de validación. |
| `0cf3fff` | Integración de Firebase Authentication y sesión. |
| `89aa902` | CRUD de tareas con Firestore y prueba unitaria. |

Rama de entrega: `semana16-integracion`. No se incluyen credenciales privadas ni datos personales en esta documentación.
