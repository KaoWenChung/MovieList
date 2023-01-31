# MovieList
This app allows users to get all movies released after the year 2000 and contain 'love' in their titles.
* Users have to sign-up/ sign-in an account before using the APP

## Instruction
You need to sign up [OMDb API](http://www.omdbapi.com/apikey.aspx) in order to get API Key.<br/>
Please add your OMDb API Key at
`~/MovieList/MovieList/Application/AppConfigurations.swift`<br/>
Or search by keyword "// TODO: ADD API KEY HERE" in the project. <br/>
Modify the method getAPIKey in AppConfigurations.

## Features
### UI Implementation
- LoginView
- RegisterView
- MovieListView: Present the movies list and order by their release year from lowest to highest.
### Sign-up/ Sign-in
- implement sign-up/ sign-in features by Firebase services.
### Login by biometric authentication (Face ID or fingerprint)
- Automatically login app if the user has login before
### Show movies information
- Get movie list by GET API http://www.omdbapi.com/
  - Implement paginating requests in API. Users will be able to see the movies ordered by their release year from lowest to highest on the same page as they scroll it.
### Localized Content
- Used Extension protocol with enumeration to define and use localized strings.
### Testing
- Unit test
  - Implement dependency injection and mock dependencies to improve the testability of code.
### Image Cache
- Implement image cache by NSCache
### Persistent storage
- Save the user's password by Keychain
- Save the user's account (email) by UserDefault

## Technologies:
- Swift
- MVVM + Coordinator
- Clean Architecture
- REST API
- Interface Builder(.xib)
- POP (protocol LocallizedStringType, Alertable, Loadingable)
- OOP
- Unit testing
- Observable
- Image Cache (NSCache)
- Persistent storage (Keychain, UserDefault)
- Dependency Injection
- Singleton pattern (Spinner, UserDefault)

## To-Do list of features and time I need:
- [x] Implement Face Id or Touch Id to log in - 2 hour
- [ ] Improve unit/ UI testing coverage - 1 hour ~
