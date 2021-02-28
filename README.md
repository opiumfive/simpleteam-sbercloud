# SberCode
Приложение SberCloud Monitor

```bash
#команда для билда релизной апк 
flutter build apk --split-per-abi
```
```bash
#команда для запуска релизной апк 
flutter run --release
```

### Архитектура
``Change Notifier`` + ``Provider``  - Uses the ``ChangeNotifier`` class from Flutter with provider package now recommended by the Flutter team.

[Зависимости](pubspec.yaml) - зависимости

### Данные 
[Реализация API](lib/api) - авторизация, получения данных проекта, пользователя, метрики, квоты, алармы

[Интерфейс API](lib/api/api.dart) - интерфейс апи, кратко

[Модели](lib/models) - данные которые мы получем

### Интерфейс
[Реализация интерфейса](/lib/ui) - навигация, экраны, вьюхи

[App](lib/main.dart) - апп, провайдеры, роутинг

### Ресурсы

[Изображения](assets/images)
[Шрифты](fonts/)
