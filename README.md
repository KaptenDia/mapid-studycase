# MAPID Mobile Application

A modern, production-ready, and highly scalable Flutter application designed with **Feature-First Clean Architecture**, **Riverpod State Management**, and **Dependency Injection**.

---

## 🚀 Key Highlights & Tech Stack

- **Architecture**: Feature-First Clean Architecture (`data`, `domain`, `presentation`).
- **State Management**: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) + [riverpod_annotation](https://pub.dev/packages/riverpod_annotation) with code generation.
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) + [injectable](https://pub.dev/packages/injectable) with automatic service discovery.
- **Network Layer**: [Dio](https://pub.dev/packages/dio) with `AuthInterceptor`, [flutter_pretty_dio_logger](https://pub.dev/packages/flutter_pretty_dio_logger), and [samseer](https://pub.dev/packages/samseer) in-app network inspector for dev/staging.
- **Local Storage**: [encrypt_shared_preferences](https://pub.dev/packages/encrypt_shared_preferences) for secure, AES-encrypted key-value storage.
- **Responsiveness**: [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) for pixel-perfect adaptivity across different screen densities and sizes.
- **Localization (i18n)**: In-house `TranslationService` supporting real-time language switching (English & Bahasa Indonesia included).
- **Flavors**: Built-in environment support (`dev`, `staging`, `prod`) using `flutter_flavorizr`.

---

## 📁 Project Structure

```text
lib/
├── config/                     # App-wide configurations
│   ├── di/                     # Dependency injection (GetIt & Injectable)
│   └── dio/                    # Dio interceptors (AuthInterceptor, etc.)
├── const/                      # App constants
│   ├── code.dart               # HTTP & API response codes
│   ├── icon.dart               # Standard icon asset paths
│   ├── image.dart              # Standard image asset paths
│   ├── url.dart                # Base URLs per environment & endpoints
│   └── validation_type.dart    # Form validation types enum
├── helper/                     # Shared utilities & helpers
│   ├── api/                    # ApiClient, ApiHelper, ResultResp
│   ├── date_helper.dart        # Date formatting & timeAgo helpers
│   ├── navigator.dart          # Context-free AppNavigator & dialogs
│   ├── samseer_notification_bridge.dart # In-app notification debugger
│   ├── string_display_helper.dart       # Initials & string formatters
│   ├── utils.dart              # General utilities
│   └── validator_helper.dart   # Email, phone, password validators
├── module/                     # Feature-first modular directory
│   ├── auth/                   # Authentication landing, OTP & Forgot Password
│   ├── home/                   # Main dashboard, tab navigation & component showcase
│   ├── login/                  # Clean Architecture Login (data, domain, presentation)
│   ├── notification/           # Notification list with category filters
│   ├── onboarding/             # Onboarding walkthrough with language switcher
│   ├── profile/                # User profile, personal info, & settings
│   ├── register/               # Clean Architecture Register
│   └── splash/                 # Splash screen with permission checks & routing
├── shared/                     # Reusable across all modules
│   ├── themes/                 # AppColors, AppTextStyle, AppFieldStyle, Themes
│   ├── translation/            # TranslationService, TranslationProvider
│   └── widget/                 # CustomButton, CustomFormField, CustomAppBar, Modals, Toast
├── flavors.dart                # Flavor configuration (dev, staging, prod)
├── main.dart                   # Application entry point
└── firebase_options.dart       # Firebase platform configuration
```

---

## 🧩 Included Starter Modules

| Module | Description |
|---|---|
| **Splash** | Animated startup screen with automatic permission requests and routing. |
| **Onboarding** | Welcome screen with real-time language switcher (`EN` / `ID`). |
| **Auth & Login** | Full Clean Architecture authentication (Repository, UseCase, StateNotifier, Form validation). |
| **Home Dashboard** | Overview dashboard with welcome banner, metrics, and quick action grid. |
| **Components Showcase** | Interactive preview of `CustomButton`, `CustomFormField`, dialogs, bottom sheets, and design system tokens. |
| **Notifications** | Notification center with unread badges, relative time stamps, and category filter chips (`All`, `System`, `Promos`, `Updates`). |
| **Profile** | User details, Personal Information editor, Language selector modal, and Logout dialog. |

---

## 🛠️ Getting Started

### 1. Prerequisites
- Flutter SDK `^3.8.1` or newer.
- Dart SDK `^3.8.1` or newer.

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Code
Whenever you add or modify `@injectable`, `@lazySingleton`, or `@riverpod` annotations, run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

To watch for changes during development:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## 🏃 Running Flavors

You can run the app with different flavors depending on your target environment:

### Development (default)
```bash
flutter run --flavor dev -t lib/main.dart
```

### Staging
```bash
flutter run --flavor staging -t lib/main.dart
```

### Production
```bash
flutter run --flavor prod -t lib/main.dart
```

---

## 🏗️ Adding a New Feature (Clean Architecture)

When adding a new module under `lib/module/<feature_name>/`, follow the 3-layer structure:

1. **`data/`**:
   - `model/`: Data Transfer Objects (DTOs) with `fromJson` and `toJson`.
   - Datasources: Remote API calls or local cache (`@lazySingleton`).
   - Repository Implementation: Implements the domain repository interface (`@lazySingleton`).
2. **`domain/`**:
   - Entities: Business models.
   - Repository Interface: Abstract contract.
   - Use Cases: Business logic classes (`@lazySingleton`).
   - State: Immutable state class for the feature.
3. **`presentation/`**:
   - `*_provider.dart`: Riverpod notifier (`@riverpod`) managing state via use cases.
   - `*_screen.dart`: UI screen utilizing Riverpod (`ConsumerWidget` or `ConsumerStatefulWidget`).

Once added, run `dart run build_runner build --delete-conflicting-outputs` to generate the dependency injection and Riverpod files.

---

## 🌐 Internationalization (i18n)

Translations are stored in JSON format under `assets/translation/`:
- `assets/translation/en.json` (English)
- `assets/translation/id.json` (Bahasa Indonesia)

### Usage in Widgets
```dart
// Access translation service via context extension:
final l10n = context.translation;

// Translate a key:
Text(l10n.t('common.save'));

// Change language dynamically:
await l10n.setLanguage('id'); // or 'en'
```

---

## 🎨 Theming & Customization

- **Colors**: Update color tokens in `lib/shared/themes/app_colors.dart`.
- **Typography**: Modify text styles in `lib/shared/themes/app_text_style.dart`.
- **App Logo**: `AppLogo` in `lib/shared/widget/logo/app_logo.dart` provides an elegant vector badge by default, or accepts a custom `assetPath` if an image is provided.
- **Global Theme**: Change the seed color in `lib/main.dart` under `ThemeData(colorScheme: ColorScheme.fromSeed(...))`.

---

## 🧪 Testing & Quality

Run code analysis:
```bash
flutter analyze
```

Run automated tests:
```bash
flutter test
```
