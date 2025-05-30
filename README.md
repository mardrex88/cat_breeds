# Cat Breeds App

Aplicación Flutter para explorar razas de gatos, ver detalles y características de cada una, consumiendo la API pública de TheCatAPI.

## Descripción

Este proyecto fue desarrollado como parte de un reto técnico. Permite buscar, listar y ver detalles de distintas razas de gatos, mostrando imágenes y descripciones relevantes.

## Tecnologías y dependencias

- **Flutter** (SDK >=3.0.0)
- **Dart**
- **flutter_bloc**: para gestión de estado
- **http**: para consumo de APIs REST
- **Equatable**: para comparación eficiente de estados
- **TheCatAPI**: fuente de datos de razas e imágenes

## Arquitectura

Se implementó una arquitectura **Clean Architecture** con separación en capas:

- **Data**: datasources y modelos para acceso a la API.
- **Domain**: entidades y casos de uso (use cases).
- **Presentation**: widgets, páginas y lógica de UI.
- **Bloc Pattern**: para la gestión de estado reactiva y desacoplada.

## Patrones de diseño utilizados

- **BLoC (Business Logic Component)**: separación de lógica de negocio y presentación.
- **Repository Pattern**: para abstraer el acceso a datos.
- **FutureBuilder**: para manejo de datos asíncronos en la UI.
- **Widget personalizado**: para reutilización de componentes de información.

