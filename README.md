# Menu Assistant 🍽️🔍

A Flutter-based mobile app that helps users identify potential dietary risks in restaurant menus using on-device OCR (Google ML Kit) and a rule-based allergen analysis engine.

It highlights menu items that explicitly mention allergens or ingredients and identifies menu descriptions that may imply allergen risks through common culinary terminology.

---

## Why This Project Exists

People living with food allergies, intolerances, or dietary restrictions often face uncertainty when ordering from restaurant menus. Many menus provide limited ingredient information, making it difficult to determine whether a meal may contain ingredients that should be avoided.

As a developer passionate about transitioning into **Artificial Intelligence and Machine Learning**, I engineered this application to solve a personal, real-world pain point. It combines computer vision with rule-based decision logic to transform unstructured menu text into meaningful dietary guidance.

---

## Key Features & What to Expect

- **Multi-profile management:** Create multiple user profiles on-device and switch between them depending on who’s dining.
- **On-device OCR engine:** Uses Google ML Kit Text Recognition to parse menu text and produce spatial layout information (bounding boxes) without needing network connectivity.
- **Explainable risk overlays:** Renders translucent, color-coded risk boxes over menu items using the active profile’s rules.
- **Privacy-first design:** No external cloud storage; profile data and images remain on the device.

--- 

## 🏗️ System Architecture & Workflow

The mobile application handles data across a highly modular, decoupled pipeline:

1. **Profile State Layer:** The user chooses an active profile. The app pulls their local dictionary array from the local database.
2. **Text Capture Pipeline:** An image/PDF of a menu (e.g., a local restaurant menu snapshot) is loaded into memory.
3. **ML Inference:** The native OCR engine extracts strings alongside spatial `Rect` geometric layouts.
4. **Contextual Evaluation Engine:** Strings are evaluated against explicit and hidden trigger rulesets (e.g., identifying that "Brioche" maps to a high-risk wheat category).
5. **UI Custom Painting:** The interface places interactive, tappable bounding boxes over the text layout.

---

## ⚠️ Disclaimer & Safety Notice

This is a personal learning project. It is not published on any commercial app stores and is intended purely for technical demonstration.

***Text-parsing and automated dictionary matching are subject to optical quality faults and unexpected menu layouts.***

***This application does not account for back-of-house kitchen cross-contamination.*** 

**CRITICAL: Always consult directly with your waiter or food server before placing an order.**

---

## Tech Stack & Dependencies

| Category | Technology |
|----------|------------|
| Framework | Flutter |
| Language | Dart |
| Architecture | MVC |
| OCR | Google ML Kit |
| Database | Isar |
| IDE | VS Code |
| Target Platform | Android (initially) |

* **Framework:** Flutter (Cross-platform development targeted from a Windows environment)
* **Language**: Dart
* **Local Storage Layer:** Isar Database
* **Machine Learning SDK:** Google ML Kit Text Recognition (google_mlkit_text_recognition)
* **UI Controls:** Custom Painters & Absolute Stack Position Matrixing
* **IDE:** VS Code

---

## Learning Objectives

This project was created to strengthen my understanding of:

- Flutter application development
- MVC architecture
- Mobile UI/UX design
- Local database management
- Optical Character Recognition (OCR)
- On-device Machine Learning
- Software Architecture
- Mobile Accessibility
- Privacy-first application design

---

## Project Status

🚧 **Currently in Development**

***Completed:***

* ✅ Project Planning
* ✅ System Architecture
* ✅ MVC Structure
* ✅ Splash Screen
* ✅ User Profiles
* ✅ OCR Engine
* ✅ Menu Analysis
* 👩🏽‍💻 Risk Overlay
* ⬜ Local Database
* ⬜ Testing

---

## Project Structure

lib/
│
├── controller/
├── model/
├── services/
├── utils/
├── view/
│   ├── splash/
│   ├── disclaimer/
│   ├── profiles/
│   ├── scanner/
│   └── results/
│
├── widgets/
│
└── main.dart

---

## Screenshots

Coming Soon

---

## Getting Started

Clone the repository:

```bash
git clone https://github.com/ShalomSJ/Menu-Assistant.git
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

## Future Improvements

- Context-aware ingredient inference

- PDF menu parsing

- Camera live scanning

- Multi-language OCR

- Restaurant menu history

- Cloud synchronization

- Accessibility improvements

- Explainable AI recommendations

- Restaurant-specific allergen databases

---

## License

This project is intended for educational purposes.

It is provided as-is without any warranty and should not be relied upon for medical or dietary decisions.

