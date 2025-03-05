# lanars_flutter_test_task
A Flutter Media Mobile App for a Test Task

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)


## Features
- Validates a login input from the user
- Fetches pictures and user info from the Web using Rest APIs (dio)
- clean architecture, with code generation, jsonSerializable models
- bloc state management, with equatable.
- a beautiful custom UI, based on a Figma Design

## Tech Stack
- Flutter ^3.5.0
- Dart
- Bloc, Equatable (State management)
- Dio, JsonSerializable, Retrofit (Rest API)
- Auto_Route (Routing)

## Architecture
This project follows a **Clean Architecture** structure with the following layers:
- `data`: API services and local storage (static variables).
- `domain`: Business logic and entities.
- `presentation`: UI and state management (Bloc).

## Setup
To use the Pictures API, you should:
1. Get api key from pexels [here](https://www.pexels.com/api/key/)

2. In the root of the project, create a `.env` file

3. Paste your key like this: `API_KEY='Your Key Here'`

4. Then run `pub get` to get all dependencies for the project.

5. And run the project.
