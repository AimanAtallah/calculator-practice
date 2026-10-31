# Calculator Practice

A SwiftUI calculator with a familiar keypad and a sheet for reviewing calculation history.

**Swift · SwiftUI · Xcode**

---

## Features

- Addition, subtraction, multiplication, and division.
- Decimal input, percentage conversion, and sign changes.
- Delete and all-clear controls.
- Calculation history with options to clear the list or close the sheet.
- A four-column keypad with gray number keys and orange operation keys.

## Open and run

Use macOS with Xcode and the SDKs required by the project. The checked-in settings target iOS and macOS **26.1** and also list visionOS platforms; choose a compatible destination in Xcode.

```sh
git clone https://github.com/AimanAtallah/calculator-practice.git
cd calculator-practice
open "calculator practice.xcodeproj"
```

Select the calculator app scheme, choose an available simulator or supported destination, and press **Run**. Running on a physical device may require configuring your signing team.

## Code guide

| Path | Purpose |
| --- | --- |
| `calculator practice/ContentView.swift` | Keypad, input state, calculation logic, and history sheet |
| `calculator practice/calculator_practiceApp.swift` | SwiftUI app entry point |
| `calculator practiceTests/` | Swift Testing starter target |
| `calculator practiceUITests/` | UI launch and performance test scaffolding |

## Current behavior

Calculations use one pending operator at a time. History is stored in view state during the running session, with no disk persistence. Division by zero currently returns `0` rather than displaying an error.

This is a SwiftUI learning project. The test targets are primarily starter scaffolding and do not yet provide comprehensive arithmetic coverage.
