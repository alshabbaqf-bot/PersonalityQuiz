<h1 style="text-align:center">Personality Quiz App</h1>

<p>The Personality Quiz App is an iOS application developed using Swift and UIKit.
The app allows users to select from multiple personality quizzes, answer different types of questions, receive a personalized result, and view previously completed quizzes.</p>

## Table of Contents

&nbsp;&nbsp;&nbsp;&nbsp;[Features](#features)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Compatibility](#compatibility)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Setup Instructions](#setup-instructions)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Architecture](#architecture)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[Figma Prototype](#figma-prototype)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;[References](#references)<br/>

## Features
   -  Multiple quiz selection from intro screen
   -	Dynamic question rendering using UIStackView
   -	Single-choice, multiple-choice, and ranged (slider) questions
   -	Randomized question order
   -	Randomized answer order (single & multiple types)
   -	Timer per question (10 seconds)
   -	Automatic timeout handling
   -	Results calculation based on most frequent answer
   -	Local storage using UserDefaults
   -	Completed quizzes history screen

## Compatibility

The app is compatible with both iPads and iPhones. It has been tested on multiple screen sizes to ensure seamless integration with various iOS devices.

- **iPad Air 11-inch (M3)**: Main testing device for iPad compatibility.
- **iPhone 16 Pro**: Main testing device for iPhone compatibility.
- **Xcode 16.4**: Version using for develop.

Both devices are running on iOS 18.0.

## Setup Instructions

1. **Clone the Repository**:
   - Open Xcode and select "Clone Git Repository". <br>
   - Enter the repository URL: [`https://github.com/memezsxz/YellaEvent.git`](https://github.com/alshabbaqf-bot/PersonalityQuiz.git) and click on "Clone".
   - Choose a local directory to save the project.

2. **Open the Project**:
   - Open the project in Xcode 16.4
3. **Select Simulator**:
   - Select an iPhone or iPad Simulator
   - (e.g., iPhone 16 Pro, iPad Air 11-inch (M3)).

5. **Run the App**:
   - Click the run button in Xcode or (⌘R).
   - Wait for the simulator to launch and deploy the app.

## Architecture

The app is built using the **Model-View-Controller (MVC)** architecture pattern. This structure ensures a clear separation of concerns, improves maintainability, and makes the project easier to extend.

- **Model**: Contains the data structures and business logic of the app, including quiz definitions, questions, answers, and local persistence.
- **View**: Responsible for presenting the user interface. This includes storyboard layouts, table view cells, and dynamically generated UI elements using UIStackView.
- **Controller**: Manages user interaction, handles navigation between screens, connects models to views, and controls application flow.


## Figma Prototype

**Figma Link:**
[`https://www.figma.com/design/yzZ3s2oOWU6oHcGa8h3jTN/Personality-Quiz?m=auto&t=ZjhA1Fj9dq1WU120-1`](https://www.figma.com/design/yzZ3s2oOWU6oHcGa8h3jTN/Personality-Quiz?m=auto&t=ZjhA1Fj9dq1WU120-1)

The prototype demonstrates the full user flow:
   - Quiz selection
   - Question flow
   - Results screen
   - Completed quizzes screen

## References
   -  Apple Developer Documentation
   -  Swift Documentation
   -  SF Symbols

