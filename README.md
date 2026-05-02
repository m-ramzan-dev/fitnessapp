# Fitness App

## 🧩 Dependencies Used & Why

| Dependency | Version | Purpose |
|---|---:|---|
| `provider` | `^6.1.5+1` | Used for state management. Controllers manage screen logic and notify UI when data changes. |
| `flutter_svg` | `^2.2.4` | Used to render SVG mood face assets exported from Figma. |

### Why Provider?
`provider` was used because it is lightweight, simple, and suitable for this project.  
It helps keep the UI clean by moving business logic into controllers.

---

## 🗂 Project Structure

```text
lib/
 ├── controllers/
 ├── models/
 ├── views/
 ├── shared/
 ├── utils/
 └── main.dart
```

### `controllers/`
Contains Provider controllers responsible for business logic and state management.  
Main controllers: `NutritionController`, `PlanController`, `MoodController`

### `models/`
Contains data models representing the structure of data used in the app.  
Example: `WorkoutEntry`

### `views/`
Contains the main app screens: `NutritionScreen`, `PlanScreen`, `MoodScreen`.  
Each screen is a reusable page widget. Bottom navigation and scaffold-level layout are handled separately.

### `views/widgets/`
Contains reusable UI components used within parent screens.

### `shared/`
Contains reusable UI components used across different screens.  
Example: `BottomNavigationBar`, `Custom Primary Button`

### `utils/`
Contains shared utilities, constants, enums, colors, and helper methods.  
Example: `AppColors`, `Extensions`, `Enum`

### `main.dart`
Application entry point. Initializes the app, registers providers, applies the app theme, and starts the root widget.

---

## 🖼 Assets

```text
assets/
├── icons/
│   └── mood/
│       ├── mood_calm.svg
│       ├── mood_content.svg
│       ├── mood_happy.svg
│       └── mood_peaceful.svg
└── fonts/
    └── static/
        ├── Mulish-Regular.ttf
        ├── Mulish-Medium.ttf
        ├── Mulish-SemiBold.ttf
        └── Mulish-Bold.ttf
```

---

## 📸 Screenshots

[View Screenshots](https://github.com/m-ramzan-dev/fitnessapp/tree/main/screenshots)

---

## 🎥 Watch App Demo

[Watch App Demo Video](https://drive.google.com/file/d/1g3dIPRBa9H_k7-JPCkttZoQTIiPzsceD/view?usp=sharing)

---

## 📦 Download Android APK

[Download APK](https://github.com/m-ramzan-dev/fitnessapp/releases/download/v1.0/app-release.apk)