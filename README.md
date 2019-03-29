## EmergenSeek Client
The mobile client for the EmergenSeek platform, developed using Google's Flutter framework.

Trello Board: https://trello.com/b/D9rcz38x/mobile-client

## Setup
- To automatically install the required dependencies, run: `flutter packages get` within the flutter_app directory.

## Dependencies
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [scoped_model](https://pub.dartlang.org/packages/scoped_model#-installing-tab-)
- [http library](https://pub.dartlang.org/packages/http#-installing-tab-)
- [geolocator library (v2.1.1)](https://pub.dartlang.org/packages/geolocator#-installing-tab-)
- [firebase_auth (v0.7.0)](https://pub.dartlang.org/packages/firebase_auth#-installing-tab-)
- [contacts_service (v0.9.0)](https://pub.dartlang.org/packages/contacts_service#-installing-tab-)

## Project Structure
- `/models`
    - Data models of application features, utilized by a global app_model
- `/screens`
    - The graphical views of the application
- `/services`
    - Data controller functionalities and backend API interfaces
- `/util`
    - Handy widgets used in constructing others
    
### References
  - https://pub.dartlang.org/packages/scoped_model
  - https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple
  - https://medium.com/@jimmyhott/using-futurebuilder-to-create-a-better-widget-4c7d4f52a329
  - https://codelabs.developers.google.com/codelabs/flutter-firebase/#0
  - https://medium.com/flutterpub/flutter-how-to-do-user-login-with-firebase-a6af760b14d5
  - https://medium.com/flutter-community/exploring-google-maps-in-flutter-8a86d3783d24
