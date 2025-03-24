# task_management

A new Flutter project.

## Getting Started

Project Overview
This is a Task Management mobile application developed using Flutter and Dart. The application allows users to create, view, and manage tasks with features such as task creation, retrieval, and display. The app follows Clean Architecture principles and uses BLoC for state management.

Tech Stack
Frontend: Flutter (Dart)

State Management: BLoC (Flutter BLoC package)

API Integration: HTTP (API calls to perform CRUD operations on tasks)

Architecture: Clean Architecture

Dependency Injection: GetIt (for managing dependencies)

Explanation of Folder Structure:
core/: Contains common utilities that can be used across features. This includes error handling and helper classes.

features/task_management/: The core module for managing tasks. This module is further split into data, domain, and presentation layers.

data/: Contains the classes that interact with external resources, such as the API services and repositories.

domain/: This contains the core business logic, such as entities and use cases.

presentation/: Contains the UI components, BLoC files for managing state, and screens.
