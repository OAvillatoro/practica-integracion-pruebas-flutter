# Mapa de flujos críticos

## F-01 — Registro de cuenta

**Precondición:** no existe una sesión activa.

`Login → Regístrate → completar correo/contraseña/confirmación → Crear cuenta → sesión autenticada → lista de tareas`

- Validaciones: campos requeridos, formato básico de correo, mínimo de seis caracteres y contraseñas coincidentes.
- Resultado esperado: Firebase crea la cuenta y `authStateChanges()` muestra el área autenticada.
- Evidencias: [formulario](evidencias/capturas-aplicacion/03-registro.png), [registro completado](evidencias/capturas-aplicacion/04-registro-completado.png), [registro exitoso](evidencias/capturas-aplicacion/05-registro-exitoso.png) y [usuario en Firebase](evidencias/firebase/01-usuario-registrado.png).

## F-02 — Inicio, persistencia y cierre de sesión

**Precondición:** existe una cuenta de prueba registrada.

`Login → credenciales → Ingresar → lista de tareas → recargar navegador → sesión conservada → Cerrar sesión → Login`

- Los errores de credenciales se presentan en español sin exponer detalles internos.
- Resultado esperado: sólo una sesión válida abre el área autenticada; cerrar sesión regresa al login.
- Evidencias: [login inválido](evidencias/capturas-aplicacion/07-login-invalido.png), [login exitoso](evidencias/capturas-aplicacion/08-login-exitoso.png), [persistencia](evidencias/capturas-aplicacion/09-persistencia-sesion.png) y [cierre](evidencias/capturas-aplicacion/06-cierre-sesion.png).

## F-03 — Crear y listar tareas

**Precondición:** sesión iniciada.

`Lista vacía → Nueva tarea → título/descripción → Crear → escritura Firestore → tarea visible`

- Se guardan `completed: false` y marcas de tiempo del servidor.
- Resultado esperado: la tarea aparece en el stream del UID actual; otras cuentas no acceden a ella.
- Evidencias: [estado vacío](evidencias/capturas-aplicacion/10-lista-vacia.png), [formulario](evidencias/capturas-aplicacion/11-formulario-crear-tarea.png), [primera tarea](evidencias/capturas-aplicacion/12-primera-tarea-creada.png), [dos tareas](evidencias/capturas-aplicacion/14-listado-dos-tareas.png) y [documentos Firestore](evidencias/firebase/03-tareas-firestore.png).

## F-04 — Editar y cambiar estado

**Precondición:** existe al menos una tarea.

`Menú de tarea → Editar → cambiar datos → Guardar → lista actualizada → marcar casilla → completada`

- La edición actualiza `title`, `description` y `updatedAt`.
- Marcar la casilla actualiza `completed` y presenta el título tachado.
- Evidencias: [menú](evidencias/capturas-aplicacion/15-menu-acciones-tarea.png), [edición](evidencias/capturas-aplicacion/16-formulario-editar-tarea.png), [resultado](evidencias/capturas-aplicacion/17-tarea-editada.png) y [completada](evidencias/capturas-aplicacion/18-tarea-completada.png).

## F-05 — Eliminar una tarea

**Precondición:** existe al menos una tarea.

`Menú de tarea → Eliminar → confirmar → borrado Firestore → tarea desaparece`

- La confirmación evita eliminaciones accidentales.
- Resultado esperado: al confirmar se elimina sólo el documento seleccionado.
- Evidencias: [acción eliminar](evidencias/capturas-aplicacion/19-menu-eliminar-tarea.png), [confirmación](evidencias/capturas-aplicacion/20-confirmacion-eliminar.png) y [resultado](evidencias/capturas-aplicacion/21-tarea-eliminada.png).

## Controles transversales

- Las rutas usan el UID autenticado: `users/{userId}/tasks/{taskId}`.
- Las reglas publicadas y la copia local restringen el acceso al propietario: [reglas](evidencias/firebase/02-reglas-firestore.png).
- Carga y errores tienen representación visual. **No ejecutado:** recuperación ante una interrupción real de red.
