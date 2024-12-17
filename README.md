# lanars_flutter_test_task
A Flutter Mobile App for a Test Task from Lanars

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)


## Features
- Validate a login input from the user
- Fetch pictures and user info from the Web using Rest APIs (dio)
- clean architecture, with code generation, jsonSerializable
- bloc state management, equatable.
- a beautiful custom UI, based on a Figma Design

## Tech Stack
- Flutter 3.5.0
- Dart
- Bloc (State management)
- Dio, JsonSerializable (Rest API)

## Architecture
This project follows a **Clean Architecture** structure with the following layers:
- `data`: API services and local storage (static variables).
- `domain`: Business logic and entities.
- `presentation`: UI and state management (Bloc).
