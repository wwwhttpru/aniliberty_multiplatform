# kira_gallery

Widgetbook showcase for the [`kira_ui`](../kira_ui) design system (KIRA).

Component use-cases live under `lib/use_cases/`, annotated with
`@widgetbook.UseCase`. The directory tree is code-generated.

## Develop

```bash
# from the workspace root
flutter pub get

# regenerate the widgetbook directory tree after adding/removing use-cases
cd packages/kira_gallery
dart run build_runner build

# run the gallery
flutter run -d chrome        # or any connected device
```
