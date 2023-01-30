# MovieList (work in progress)
* User have to sign-up/sign-in an account before using the APP

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
- MovieListView: Present the movies list and ordered by their release year from lowest to highest.
### Sign-up/ Sign-in
- implement sign-up/sign-in features by Firebase services.
### API Data Fetching
- Get movie list by GET API http://www.omdbapi.com/
  - Pagination
### Localized Content
- Used Extension protocol with enumeration to define and use localized strings.
### Test Implementation
- Unit testing
  - Implement dependency injection and mock dependencies to improve the testability of code.
### Image Cache
- Implement image cache by NSCache

### Technologies:
- Swift
- MVVM + Coordinator
- Interface builder(.xib)
- Clean Architecture
- POP (protocol LocallizedStringType)
- Firebase (sign-up/sign-in)
- OOP
- Unit testing
- Observable
- Image Cache (NSCache)
- Dependency Injection
- Singleton pattern (Spinner)

## To-Do list of features and time I need:
- [ ] Implement Face Id or Touch Id to login - 2 hour
