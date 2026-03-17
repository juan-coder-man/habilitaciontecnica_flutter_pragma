# Habilitación técnica Flutter – Fase 1

Aplicación básica en Flutter con listado de elementos, pantalla de detalles y formulario para agregar o editar. Desarrollada como prueba técnica siguiendo Clean Architecture, SOLID y Clean Code.

## Descripción

- **Pantalla principal (HomeScreen)**: listado de tarjetas; al tocar una se navega a detalles; botón flotante para ir al formulario de alta.
- **Pantalla de detalles (DetailsScreen)**: muestra la información del elemento; botones para editar (navega al formulario) y eliminar (con confirmación).
- **Pantalla de formulario (FormScreen)**: permite crear un nuevo elemento o editar uno existente; validación de título obligatorio; botón para guardar/agregar.

## Diseño de la aplicación

Se sigue **Clean Architecture** con dependencias hacia el dominio:

- **Domain**: entidad `Item` (id, title, description, createdAt) e interfaz `ItemsRepository` (lista, por id, add, update, remove). Sin dependencias de Flutter.
- **Data**: `ItemsMemoryDatasource` (lista en memoria e IDs incrementales) e `ItemsRepositoryImpl` que implementa el contrato y extiende `ChangeNotifier` para notificar cambios.
- **Presentation**: pantallas y widgets (p. ej. `ItemCard`); consumen el repositorio vía `Provider` y usan rutas nombradas con argumentos.

La **navegación** se centraliza en `AppRoutes.onGenerateRoute`: rutas `home`, `details` y `form`; los argumentos se pasan por `RouteSettings.arguments` (en detalles y formulario se usa `Item` o `Item?`).

El **estado** se mantiene en memoria mediante el repositorio inyectado con `Provider`; la UI se actualiza al llamar a `notifyListeners()` tras add/update/remove.

## Consideraciones

- La interfaz `ItemsRepository` en domain permite cambiar en el futuro la fuente de datos (persistencia, API) sin tocar la presentación.
- En detalles se vuelve a obtener el ítem por id desde el repositorio, de modo que si se editó desde el formulario y se regresó, se muestra la versión actualizada.
- Eliminar muestra un diálogo de confirmación antes de borrar.
- Lista vacía y “elemento no encontrado” (p. ej. id inválido o ya eliminado) tienen mensajes y acciones claras.

## Cómo ejecutar

```bash
flutter pub get
flutter run
```

## Tests

```bash
flutter test
```
