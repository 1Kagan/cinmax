# 🎬 Cinmax

A modern Flutter application built with **Clean Architecture**, **BLoC Pattern**, and **AutoRoute** for a scalable and maintainable codebase.

## 👨‍💻 Developer

**Kağan Kılıç** - Mid-Senior Flutter Developer  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/kağankılıç)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)](https://github.com/1Kagan)

---

## 🏗️ Architecture & Technologies

### 🎯 Core Architecture
- **Clean Architecture** - Separation of concerns with clear layer boundaries
- **BLoC Pattern** - Predictable state management with business logic separation
- **Dependency Injection** - Modular and testable code structure
- **Repository Pattern** - Abstracted data layer for better testability

### 🚀 Key Technologies
- **AutoRoute** - Type-safe navigation and routing
- **Flutter Localizations** - Multi-language support (EN/TR)
- **Multi-Flavor Setup** - Development, Staging, Production environments
- **Core Design Language System** - Reusable UI components package
- **Secure Storage** - Encrypted local data storage
- **Network Layer** - Dio with custom interceptors and error handling

### 📱 Platform Support
- ✅ **Android**
- ✅ **iOS** 

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/username/cinmax.git
cd cinmax
```

2. **Create environment files** (Required)
Create the following environment files in the project root:

`.env.development`:
```env
BASE_URL=https://api-dev.cinmax.com
```

`.env.staging`:
```env
BASE_URL=https://api-staging.cinmax.com
```

`.env.production`:
```env
BASE_URL=https://api.cinmax.com
```

> **⚠️ Important**: The `BASE_URL` variable is required for all three environments. The app will not run without these files.

3. **Install dependencies**
```bash
flutter pub get
```

4. **Generate code**
```bash
# Generate routes and other generated files
dart run build_runner build --delete-conflicting-outputs

# Generate localizations
flutter gen-l10n
```

5. **Run the app**
```bash
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

---

## 🏗️ Project Structure

```
lib/
├── src/
│   ├── config/           # App configuration
│   │   ├── firebase/     # Firebase setup
│   │   └── router/       # AutoRoute configuration
│   ├── core/             # Core utilities and shared components
│   │   ├── components/   # Reusable UI components
│   │   ├── constants/    # App constants
│   │   ├── cubit/        # App-level state management
│   │   ├── network/      # Network layer (Dio, interceptors)
│   │   ├── theme/        # App theming
│   │   └── widgets/      # Common widgets
│   └── features/         # Feature modules (Clean Architecture)
│       ├── auth/         # Authentication feature
│       ├── dashboard/    # Dashboard feature
│       ├── home_page/    # Home page feature
│       ├── profile/      # Profile feature
│       ├── register/     # Registration feature
│       └── splash/       # Splash screen feature
└── l10n/                 # Localization files
```

Each feature follows Clean Architecture principles:
```
feature/
├── data/
│   ├── datasources/      # Remote & Local data sources
│   ├── models/           # Data models
│   └── repositories/     # Repository implementations
├── domain/
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository contracts
│   └── usecases/         # Business logic
└── presentation/
    ├── cubit/            # BLoC state management
    ├── pages/            # UI pages
    └── widgets/          # Feature-specific widgets
```

---

## 🌐 Localization

The app supports multiple languages with Flutter's internationalization framework.

### Supported Languages
- 🇺🇸 **English** (en)
- 🇹🇷 **Turkish** (tr)

### Adding New Translations

1. Add strings to `lib/l10n/arb/app_en.arb`:
```json
{
  "welcome": "Welcome",
  "@welcome": {
    "description": "Welcome message"
  }
}
```

2. Add corresponding translation to `lib/l10n/arb/app_tr.arb`:
```json
{
  "welcome": "Hoş geldiniz"
}
```

3. Use in code:
```dart
Text(context.l10n.welcome)
```

---

## 🧪 Testing

### Running Tests
```bash
# Run all tests with coverage
flutter test --coverage --test-randomize-ordering-seed random

# Generate coverage report
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

### Test Structure
- **Unit Tests** - Business logic and use cases
- **Widget Tests** - UI components and pages
- **Integration Tests** - End-to-end user flows

---

## 🔧 Development Tools

### Code Generation
```bash
# Generate routes, models, and other generated files
dart run build_runner build --delete-conflicting-outputs

# Watch for changes
dart run build_runner watch --delete-conflicting-outputs
```

### Scripts
```bash
# Build runner (from scripts folder)
./scripts/build_runner.sh

# Generate localizations
./scripts/generate_localization.sh
```

---

## 🚀 Deployment

### Flavors Configuration

The app is configured with three environments:

- **Development** - Debug builds with development API endpoints
- **Staging** - Testing environment with staging API
- **Production** - Release builds for app stores

### Environment Variables

**Required Configuration**: Before running the application, you **must** create environment files for each flavor in the project root directory.

**File Structure:**
```
cinmax/
├── .env.development    # Development environment
├── .env.staging        # Staging environment
├── .env.production     # Production environment
└── ...
```

**Required Variables:**

Each environment file must contain the `BASE_URL` variable:

**`.env.development`**
```env
BASE_URL=https://api-dev.cinmax.com
# Add other development-specific variables here
```

**`.env.staging`**
```env
BASE_URL=https://api-staging.cinmax.com
# Add other staging-specific variables here
```

**`.env.production`**
```env
BASE_URL=https://api.cinmax.com
# Add other production-specific variables here
```

> **🚨 Critical**: The `BASE_URL` variable is mandatory for all environments. The application will fail to build/run without these files. Make sure to replace the example URLs with your actual API endpoints.

---

## 📦 Core Dependencies

### State Management
- `flutter_bloc` - BLoC pattern implementation
- `bloc` - Core BLoC library

### Navigation
- `auto_route` - Type-safe routing solution
- `auto_route_generator` - Code generation for routes

### Network & Storage
- `dio` - HTTP client
- `flutter_secure_storage` - Encrypted local storage

### Localization
- `flutter_localizations` - Internationalization support
- `intl` - Date/number formatting

### Development
- `build_runner` - Code generation
- `very_good_analysis` - Lint rules
- `bloc_test` - BLoC testing utilities

### Environment Management
- `flutter_dotenv` - Environment variables management
- Multi-flavor configuration for different environments

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Built with [Flutter](https://flutter.dev/)
- Architecture inspired by [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- State management powered by [BLoC](https://bloclibrary.dev/)

---

<div align="center">
  <p>Made with ❤️ by <strong>Kağan Kılıç</strong></p>
  <p>
    <a href="https://www.linkedin.com/in/kağankılıç">LinkedIn</a> •
    <a href="https://github.com/1Kagan">GitHub</a>
  </p>
</div>
