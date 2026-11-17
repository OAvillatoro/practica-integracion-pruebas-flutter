# Casos de prueba funcionales

## Criterios

- **Aprobado (Passed):** la comprobación fue ejecutada y existe evidencia del resultado observado.
- **No ejecutado:** el resultado esperado está definido, pero la comprobación no fue realizada.
- Las credenciales válidas se describen como “cuenta de prueba” para no publicar datos personales o secretos.

| ID | Flujo | Entrada y pasos concretos | Resultado esperado | Resultado observado | Estado | Evidencia |
|---|---|---|---|---|---|---|
| CP-01 | Login vacío | Correo `""`, contraseña `""`; pulsar **Ingresar**. | Mostrar “Ingresa tu correo electrónico.” y “Ingresa tu contraseña.”; no llamar Firebase. | Se mostraron ambos mensajes; la prueba widget terminó correctamente. | Aprobado (Passed) | [validación visual](evidencias/capturas-aplicacion/02-validacion-login.png), [regresión INC-001](evidencias/pruebas-y-analisis/INC-001-regresion.txt) |
| CP-02 | Login inválido | Correo con formato válido de una cuenta de prueba y contraseña incorrecta; pulsar **Ingresar**. | Rechazar acceso y mostrar un error claro en español. | La pantalla permaneció en login y mostró error de credenciales. Los valores se omiten por privacidad. | Aprobado (Passed) | [login inválido](evidencias/capturas-aplicacion/07-login-invalido.png) |
| CP-03 | Registro | Completar los tres campos con una cuenta de prueba nueva y contraseñas coincidentes de al menos 6 caracteres; pulsar **Crear cuenta**. | Crear usuario e iniciar sesión. | El registro finalizó y el usuario apareció en Firebase Authentication. | Aprobado (Passed) | [datos completados](evidencias/capturas-aplicacion/04-registro-completado.png), [éxito](evidencias/capturas-aplicacion/05-registro-exitoso.png), [Firebase](evidencias/firebase/01-usuario-registrado.png) |
| CP-04 | Login válido | Introducir la cuenta de prueba registrada y su contraseña; pulsar **Ingresar**. | Abrir **Mis tareas**. | Se abrió correctamente el área autenticada. | Aprobado (Passed) | [login](evidencias/capturas-aplicacion/01-login.png), [resultado](evidencias/capturas-aplicacion/08-login-exitoso.png) |
| CP-05 | Persistencia | Con sesión activa, recargar la pestaña de Chromium. | Restaurar la sesión sin pedir credenciales otra vez. | La vista autenticada se conservó tras la recarga. | Aprobado (Passed) | [persistencia](evidencias/capturas-aplicacion/09-persistencia-sesion.png) |
| CP-06 | Cerrar sesión | Desde **Mis tareas**, pulsar el icono **Cerrar sesión**. | Finalizar la sesión y mostrar login. | La aplicación volvió a la pantalla de acceso. | Aprobado (Passed) | [cierre de sesión](evidencias/capturas-aplicacion/06-cierre-sesion.png) |
| CP-07 | Lista vacía | Iniciar sesión con una cuenta sin documentos en `tasks`. | Mostrar “Aún no tienes tareas” y permitir crear una. | Se presentó el estado vacío esperado. | Aprobado (Passed) | [lista vacía](evidencias/capturas-aplicacion/10-lista-vacia.png) |
| CP-08 | Validar nueva tarea | Pulsar **Nueva tarea**, dejar título `""` y pulsar **Crear**. | Mostrar “Ingresa un título.” y no escribir en Firestore. | No ejecutado. | No ejecutado | No disponible |
| CP-09 | Crear tarea | Título `Preparar informe de calidad`; descripción `Documentar las pruebas funcionales del proyecto Flutter.`; pulsar **Crear**. | Crear tarea pendiente y mostrarla en la lista. | La primera tarea apareció en la lista y Firestore mostró documentos bajo el usuario. | Aprobado (Passed) | [formulario](evidencias/capturas-aplicacion/11-formulario-crear-tarea.png), [tarea creada](evidencias/capturas-aplicacion/12-primera-tarea-creada.png), [Firestore](evidencias/firebase/03-tareas-firestore.png) |
| CP-10 | Crear segunda tarea | Título `Revisar incidencias`; descripción `Documentar las pruebas funcionales del proyecto Flutter.`; pulsar **Crear**. | Mantener la primera y añadir la segunda. | La lista mostró dos tareas. | Aprobado (Passed) | [segunda tarea](evidencias/capturas-aplicacion/13-formulario-segunda-tarea.png), [listado](evidencias/capturas-aplicacion/14-listado-dos-tareas.png) |
| CP-11 | Editar tarea | Abrir `Revisar incidencias`, pulsar **Editar**, agregar `Modificando esta tarea` a la descripción y pulsar **Guardar**. | Actualizar contenido y `updatedAt` sin duplicar la tarea. | La lista mostró la tarea editada. | Aprobado (Passed) | [menú](evidencias/capturas-aplicacion/15-menu-acciones-tarea.png), [formulario](evidencias/capturas-aplicacion/16-formulario-editar-tarea.png), [resultado](evidencias/capturas-aplicacion/17-tarea-editada.png) |
| CP-12 | Completar tarea | Pulsar la casilla de una tarea pendiente (`completed: false`). | Guardar `completed: true` y mostrar el título tachado. | La tarea se presentó como completada. | Aprobado (Passed) | [tarea completada](evidencias/capturas-aplicacion/18-tarea-completada.png) |
| CP-13 | Eliminar tarea | Menú de tarea → **Eliminar** → confirmar **Eliminar**. | Borrar únicamente la tarea seleccionada y actualizar la lista. | Se mostró confirmación y la tarea desapareció tras aceptarla. | Aprobado (Passed) | [acción](evidencias/capturas-aplicacion/19-menu-eliminar-tarea.png), [confirmación](evidencias/capturas-aplicacion/20-confirmacion-eliminar.png), [resultado](evidencias/capturas-aplicacion/21-tarea-eliminada.png) |
| CP-14 | Cancelar borrado | Menú de tarea → **Eliminar** → **Cancelar**. | Cerrar el diálogo y conservar la tarea. | No ejecutado. | No ejecutado | No disponible |
| CP-15 | Aislamiento por usuario | Iniciar con usuario A y crear una tarea; cerrar sesión e iniciar con usuario B. | El usuario B no puede leer ni modificar tareas de A. | No ejecutado; sólo se verificó la regla publicada. | No ejecutado | [reglas publicadas](evidencias/firebase/02-reglas-firestore.png) |
| CP-16 | Interrupción de red | Con la lista abierta, desconectar la red y realizar una operación; luego restablecerla y pulsar **Reintentar**. | Mostrar estado de error y recuperar la lista al volver la conexión. | No ejecutado. | No ejecutado | No disponible |

## Pruebas automatizadas

| Prueba | Tipo | Resultado |
|---|---|---|
| Formulario de login vacío | Widget | Aprobada (Passed); comprueba ambos mensajes de campo requerido sin Firebase real. |
| Construcción del modelo `Task` | Unitaria | Aprobada (Passed); comprueba ID, título, descripción y estado completado. |
| Análisis estático | Calidad | Sin incidencias. |

Evidencias: [salida de `flutter test`](evidencias/pruebas-y-analisis/flutter-test-final.txt) y [salida de `flutter analyze`](evidencias/pruebas-y-analisis/flutter-analyze-final.txt).
