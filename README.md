<h1>Personality Quiz App</h1>

<p>The Personality Quiz App is an iOS application developed using Swift and UIKit (Storyboard-based). The app allows users to select from multiple personality quizzes, answer different types of questions, receive personalized results, and view previously completed quiz history.</p>

## Table of Contents

&nbsp;&nbsp;&nbsp;&nbsp;[Features](#features)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Compatibility](#compatibility)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Setup Instructions](#setup-instructions)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Architecture](#architecture)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Prototype](#prototype)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Data Persistence](#data-persistence)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Timer Functionality](#timer-functionality)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[References](#references)<br/>

---

## Features

- Multiple quiz selection from intro screen.
- Dynamic question rendering using `UIStackView`.
- Support for:
  - Single-choice questions
  - Multiple-choice questions
  - Ranged (slider) questions
- Randomized question order.
- Randomized answer order (single & multiple types).
- Timer per question (10 seconds).
- Automatic timeout handling.
- Results calculation based on the most frequent answer.
- Completed quizzes history screen.
- Local data persistence using `UserDefaults`.
  
---

## Compatibility

The app is compatible with both iPads and iPhones and has been tested across multiple screen sizes.

- **iPad Air 11-inch (M3)**: Main testing device for iPad compatibility.
- **iPhone 16 Pro**: Main testing device for iPhone compatibility.

Both devices are running on **iOS 18**.

---

## Setup Instructions

1. **Clone the Repository**
   - Open Xcode.
   - Select *Clone Git Repository*.
   - Enter the repository URL:
     ```
     https://github.com/alshabbaqf-bot/PersonalityQuiz.git
     ```
   - Choose a local directory and clone.

2. **Open the Project**
   - Open the `.xcodeproj` file in Xcode.

3. **Select Simulator**
   - Choose an iPhone or iPad simulator (e.g., iPhone 16 Pro or iPad Air 11-inch).

4. **Run the App**
   - Press ⌘R or click the Run button.
   - The app will launch and display the quiz selection screen.

---

## Architecture

The app follows the **Model-View-Controller (MVC)** architectural pattern.

### Model
- `Quiz`
- `Question`
- `Answer`
- Business logic for result calculation
- Local storage management using `UserDefaults`

### View
- Storyboard-based UI
- Dynamic answer generation using `UIStackView`
- Slider for ranged questions
- TableView for completed quiz history

### Controller
- `QuizIntroViewController`
- `QuestionViewController`
- `ResultViewController`
- `HistoryViewController`
- Handles:
  - Navigation between screens
  - Timer management
  - Randomization logic
  - Answer tracking
  - Results calculation
  - Data storage and retrieval

---

## Prototype

A high-fidelity interactive prototype was created in Figma before development to outline the application layout and user flow.

The prototype includes:

- Quiz selection screen
- Question flow (single, multiple, ranged)
- Results screen
- Completed quizzes history screen

**Figma Prototype (Public Link):**  
```
https://www.figma.com/design/yzZ3s2oOWU6oHcGa8h3jTN/Personality-Quiz?m=auto&t=oefiTIv2d9qreOpg-1
```

---

## Data Persistence

Quiz history is stored locally using:

- `Codable`
- `JSONEncoder`
- `JSONDecoder`
- `UserDefaults`

Data is saved automatically after each completed quiz and displayed in the history screen.

---

## Timer Functionality

Each question includes a 10-second countdown timer.

- The timer automatically advances to the next question when time expires.
- If the user selects an answer before the timer ends, the timer resets for the next question.
- Timeout handling ensures smooth navigation and prevents user interaction after expiration.

---

## References

- Apple Developer Documentation
- Swift Documentation
- UIKit Framework Documentation
- SF Symbols
