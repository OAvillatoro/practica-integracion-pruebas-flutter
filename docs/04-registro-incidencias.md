# Registro de incidencias

## INC-001 — Prueba widget obsoleta

| Campo | Detalle |
|---|---|
| Estado | Cerrada |
| Severidad | Media: impedía aprobar `flutter test`, sin afectar el uso manual de la aplicación. |
| Contexto | La prueba generada por Flutter todavía esperaba el contador eliminado. Al montar `MyApp`, `AuthGate` intentaba usar Firebase sin inicialización de prueba. |
| Resultado inicial | Fallo `[core/no-app]` y búsqueda fallida del texto `0`. |
| Causa raíz | La prueba no se actualizó al sustituir el contador por el flujo de autenticación y dependía indirectamente de Firebase real. |
| Corrección | Montar `LoginScreen` directamente y comprobar la validación del formulario vacío, sin inicializar Firebase ni acceder a red. |
| Commit de corrección | `6e60685` — `fix: INC-001 replace obsolete counter widget test` |
| Regresión | Aprobada (Passed): `1` prueba, `All tests passed!`. |

- Fallo inicial: [INC-001-error-inicial.txt](evidencias/pruebas-y-analisis/INC-001-error-inicial.txt)
- Regresión: [INC-001-regresion.txt](evidencias/pruebas-y-analisis/INC-001-regresion.txt)

## Incidencias pendientes

No se identificaron ni registraron INC-002 o INC-003 durante el trabajo documentado.

| ID | Estado | Descripción | Evidencia |
|---|---|---|---|
| Pendiente de asignación | Sin incidencia reportada | Reservado para una incidencia real encontrada en una ejecución futura. No debe numerarse hasta contar con pasos de reproducción y evidencia. | Pendiente |
