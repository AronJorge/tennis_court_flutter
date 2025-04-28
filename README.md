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

# WEB - APP

<img width="1710" alt="Captura de pantalla 2025-04-27 a la(s) 8 51 02 p m" src="https://github.com/user-attachments/assets/11ffd9d1-8660-49f5-aad3-b1b4df39cef0" />
<img width="1710" alt="Captura de pantalla 2025-04-27 a la(s) 8 57 29 p m" src="https://github.com/user-attachments/assets/324d97bf-4df7-4c70-b05a-3015e5e96108" />
<img width="1710" alt="Captura de pantalla 2025-04-27 a la(s) 8 57 24 p m" src="https://github.com/user-attachments/assets/4908b7d7-3ef0-4073-9100-b266b9dbc03c" />
<img width="1710" alt="Captura de pantalla 2025-04-27 a la(s) 8 57 10 p m" src="https://github.com/user-attachments/assets/924f5383-0837-4d0d-a928-9f2c7b8ef808" />
<img width="1710" alt="Captura de pantalla 2025-04-27 a la(s) 8 57 03 p m" src="https://github.com/user-attachments/assets/cfb83025-6a30-4dc4-9cdb-3d90dc18a61e" />
<img width="1710" alt="Captura de pantalla 2025-04-27 a la(s) 8 56 52 p m" src="https://github.com/user-attachments/assets/c3c32875-42db-4530-a392-b2dafeeb2806" />
<img width="1710" alt="Captura de pantalla 2025-04-27 a la(s) 8 56 43 p m" src="https://github.com/user-attachments/assets/c598adab-4561-4b6e-b295-020f8d41cd0a" />
<img width="1710" alt="Captura de pantalla 2025-04-27 a la(s) 8 51 17 p m" src="https://github.com/user-attachments/assets/9014b4ec-08be-4c3c-9a52-f24285625e4a" />
<img width="1710" alt="Captura de pantalla 2025-04-27 a la(s) 8 51 09 p m" src="https://github.com/user-attachments/assets/242f0e1f-b49d-48cf-836a-ddc751ac67df" />

# ANDROID - APP
![Screenshot_20250427_210324](https://github.com/user-attachments/assets/ac71e836-2f91-4eb7-b57c-a8215f502b26)
![Screenshot_20250427_210318](https://github.com/user-attachments/assets/4ccf4c62-7812-4331-aa1d-1f1af1001ae9)
![Screenshot_20250427_210307](https://github.com/user-attachments/assets/06ed3c39-d53c-4092-a702-7ff73ff8330b)
![Screenshot_20250427_210258](https://github.com/user-attachments/assets/63de37b1-0022-4164-a4fc-a7910e4f9a51)
![Screenshot_20250427_210213](https://github.com/user-attachments/assets/1ad10e8f-6e8d-4930-9ab0-9f7dc1671674)
![Screenshot_20250427_210127](https://github.com/user-attachments/assets/eb0c204d-afdc-4c93-aa59-10326656c83b)
![Screenshot_20250427_210053](https://github.com/user-attachments/assets/3b492cea-decf-47f9-8e3e-cbe1b0a2cee4)
