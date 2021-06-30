## Weather Forecast

_Weather Forecast_ is a simple weather app that retrieved data from Open Weather Map, a third-party APIs that allows developers to access their data and functionality by making requests with specific parameters to a URL. This app was built with Swift 5.

## Getting started
This project was written in Swift 5 and requires XCode 12 to build and run. Only need to open the project by XCode and wait for the Swift Package Dependency to fetch libraries.

## Folder structure
This project was written using MVP architecture + Clean architecture approach, including Unit test.

weather-app
- App
- Asset
- Source
    - Core
        - *Usecases* - protocols, contains the application/business logic for a specific usecase in the app.
        - *Gateways* - protocols, belongings to Application logic, will be implemented in Gateways and Framework Logic
        - *Entities* - Swift classes/structs → models objects used by the app.
    - EntityGateway, contains the concrete implementation for the protocol defined in Core (application/business logic), ex: API Operator, Local Persistence, specifc iOS APIs (Camera, ...)
    - Scenes → Presentation logic (MVP)
         - Configurator, handle Dependency Injection
         - Presenter, contains presentation logic
         - ViewController, the view layer
         - Router (If any), contains navigational logic
- Constants, self-explanatory
- Utils, including Helpers, Extension...

weather-app-tests → Unit test, 
- presentation logic test (presenter)
- usecase test

## What I done
1. The application is a simple iOS application which is written by Swift.
2. The application is able to retrieve the weather information from OpenWeatherMaps API.
3. The application is able to allow user to input the searching term.
4. The application is able to proceed searching with a condition of the search term length must be
from 3 characters or above.
5. The application is able to render the searched results as a list of weather items.
6. The application is able to load the weather icons remotely and displayed on every weather item at
the right-hand side.
7. The application is able to handle failures.
