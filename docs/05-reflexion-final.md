# Reflexión técnica final

La integración mostró que una prueba puede quedar obsoleta aunque la aplicación funcione manualmente.
Separar la pantalla de login permitió probar su validación sin inicializar Firebase ni depender de la red.
El uso de `authStateChanges()` simplificó la transición entre estados autenticado y no autenticado.
Organizar las tareas bajo el UID y reforzarlo con reglas aporta aislamiento tanto en código como en backend.
Los streams de Firestore mantuvieron la lista sincronizada con pocas capas y un flujo fácil de seguir.
Los estados de carga, vacío y error fueron necesarios para que la interfaz comunicara el estado real de operaciones asíncronas.
Finalmente, `flutter analyze`, las pruebas automatizadas y la evidencia manual se complementaron: ninguna por sí sola cubre todo el comportamiento.
