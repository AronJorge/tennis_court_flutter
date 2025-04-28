# Tennis Court - Flutter App

**Tennis Court** - TEST APP

---

## Características principales

- **Inicio de sesión** y **registro** de usuarios.
- **Soporte para múltiples usuarios registrados** en almacenamiento local (Hive).
- **Visualización de canchas** disponibles con información de probabilidad de lluvia.
- **Reservas** de canchas con selección de fecha, hora, instructor y comentarios.
- **Favoritos**: Visualización de reservas marcadas como favoritas.
- **Internacionalización (i18n)** utilizando `flutter_gen` y archivos `.arb`.
- **Interfaz moderna e intuitiva** adaptada a dispositivos móviles.
- **Cobertura de código** con reportes automáticos en HTML.

---

## Tecnologías y paquetes utilizados

- **Flutter** 3.x
- **BLoC** para gestión de estado
- **Hive** para almacenamiento local de datos
- **SharedPreferences** para persistencia ligera de credenciales
- **Dio** para peticiones HTTP (API de clima)
- **Flutter Intl** (`flutter_gen`) para internacionalización
- **lcov** y **genhtml** para reportes de cobertura de pruebas

---

## 📂 Arquitectura del proyecto

```plaintext
lib/
 ├─ core/
 │   ├─ constants/
 │   └─ data/local_storage_service.dart
 ├─ features/
 │   ├─ auth/
 │   ├─ court/
 │   ├─ reservation/
 │   └─ common/
 ├─ l10n/
assets/
```

### Organización en features:

- **Auth**: Registro, login, autenticación.
- **Court**: Listado de canchas, información meteorológica.
- **Reservation**: Creación, listado y favoritos de reservas.
- **Common**: Entidades comunes (usuario, cancha, reserva).

Cada feature dividido en:

- `data/` (datasources, modelos)
- `domain/` (entidades, casos de uso, repositorios)
- `presentation/` (pantallas, widgets, BLoC)

---

## Separación de lógica y buenas prácticas

- Separación estricta en **Domain**, **Data** y **Presentation**.
- **Constantes** unificadas en `core/constants`.
- **Control de estado** usando `flutter_bloc` para cada módulo.
- **Strings** manejadas vía `l10n` y `flutter_gen`, nunca hardcodeadas.
- **Manejo de errores** controlado en BLoC y mostrado al usuario de forma amigable.
- **Código limpio**, siguiendo principios SOLID y DRY.

---

## Funcionalidades por módulo

### Auth

- Registro de múltiples usuarios en Hive.
- Login con verificación local.
- Manejo de usuario activo con `currentUserId`.

### Courts

- Listado de canchas desde almacenamiento local.
- Sembrado automático de canchas si no existen.
- Carga de probabilidad de lluvia en tiempo real.

### Reservations

- Crear reservas con fecha, hora, instructor, comentario.
- Listar reservas programadas.
- Ver reservas marcadas como favoritas.

### Internacionalización

- Multi idioma soportado (usando `.arb` y `flutter_gen`).
- Strings organizadas (`addCommentPlaceholder`, `reserveButton`, etc.).

---

## Pasos para ejecutar el proyecto localmente

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu_usuario/tennis_court_app.git
cd tennis_court_app
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Ejecutar la aplicación

```bash
flutter run
```

---

## Ejecutar análisis de código y pruebas unitarias

Usamos un script automático llamado **`validate_and_coverage.sh`** para analizar el código y generar el reporte de cobertura en HTML.

### Ejecutar script:

```bash
bash validate_and_coverage.sh
```

###

---

## Capturas de pantalla

| Welcome | Nueva Reserva | Reservas |
| ------- | ------------- | -------- |
|         |               |          |

