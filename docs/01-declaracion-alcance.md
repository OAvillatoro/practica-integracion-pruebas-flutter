# Declaración de alcance

## Objetivo

Aplicación web desarrollada con Flutter para que una persona autenticada administre su propia lista de tareas. La solución usa Firebase Authentication para la sesión y Cloud Firestore para persistir datos por usuario.

## Funcionalidad implementada

- Registro con correo, contraseña y confirmación de contraseña.
- Inicio y cierre de sesión; restauración de sesión mediante `authStateChanges()`.
- Validación de formularios, mensajes de error y estados de carga.
- Consulta en tiempo real de las tareas del usuario autenticado.
- Creación y edición de título y descripción.
- Cambio de estado entre pendiente y completada.
- Eliminación con confirmación.
- Estados de lista vacía, carga y error.
- Prueba widget del formulario de acceso y prueba unitaria del modelo `Task`.

## Integraciones

| Servicio | Aplicabilidad | Uso en el proyecto |
|---|---|---|
| Firebase Authentication | Aplica | Registro, acceso, cierre y persistencia de sesión con correo/contraseña. |
| Cloud Firestore | Aplica | CRUD en `users/{userId}/tasks/{taskId}`. |
| Firebase Cloud Messaging (FCM) | No aplica | No se implementaron notificaciones. |
| Firebase Storage | No aplica | La aplicación no carga ni descarga archivos. |
| API REST externa | No aplica | No existe consumo de servicios HTTP externos. |

## Datos manejados

Cada tarea contiene `title`, `description`, `completed`, `createdAt` y `updatedAt`. La ruta incorpora el UID autenticado y las reglas de Firestore limitan el acceso al propietario. La documentación no incluye correos reales, contraseñas, claves privadas ni otros datos personales.

## Fuera de alcance

- Recuperación o verificación de correo.
- Roles administrativos y uso compartido de tareas.
- Archivos adjuntos, notificaciones y sincronización con APIs externas.
- Pruebas automatizadas contra servicios Firebase reales.
- Despliegue de hosting desde este repositorio.

## Plataforma y estado

- Plataforma objetivo: Flutter Web en Chromium.
- Rama de trabajo: `semana16-integracion`.
- Estado verificado: `flutter analyze` sin incidencias y dos pruebas automatizadas aprobadas.
- Evidencia: [análisis final](evidencias/pruebas-y-analisis/flutter-analyze-final.txt) y [pruebas finales](evidencias/pruebas-y-analisis/flutter-test-final.txt).
