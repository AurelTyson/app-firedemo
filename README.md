# app-firedemo

This iOS application have been created as a demo app for [Firebase](https://firebase.google.com/).

The application is a simple todolist with shared items between all the users connected.

Modules used :
* Authentication (mail / password and Facebook)
* Database

## Presentation

The presentation is available as a PDF in the "Presentation" folder.

## Installation

Download the sources
Go to "Project" folder and run :
```
pod install
```
Open 'FireDemo.xcworkspace'

## Pod used

* [ActionKit](https://github.com/ActionKit/ActionKit)
* [FacebookCore](https://github.com/facebook/facebook-sdk-swift)
* [FacebookLogin](https://github.com/facebook/facebook-sdk-swift)
* [Firebase (v.3.8.0)](https://cocoapods.org/pods/Firebase)
* [Firebase/Auth](https://cocoapods.org/pods/Firebase)
* [Firebase/Database](https://cocoapods.org/pods/Firebase)
* [MLInputDodger](https://github.com/molon/MLInputDodger)

## Configuration

### Firebase

* Create you own Firebase account.
* Create a new app.
* Generate and replace the GoogleService-Info.plist file.
* Enable authentication from Facebook in Firebase console.

### Facebook authentication

* Enable authentication from Facebook in Firebase console.
* Create an app in [Facebook dev center](https://developers.facebook.com/apps/).
* Set the application id and passphrase of the Facebook app in Firebase console.
* Set the application id of the iOS app and the OAuth redirection URI in Facebook dev center.

## Pull requests and issues

If you want to add some features or report an issue, feel free to submit ! 
