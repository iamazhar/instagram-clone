# Instagram-Clone
[![Open Source Love](https://badges.frapsoft.com/os/mit/mit.svg?v=102)](https://github.com/ellerbrock/open-source-badge/)

With a Firebase backend; All UI created programmatically; Great reference for intermediate and beginner devs who want to create a real-world application fully programmatically.

Supports: iOS 10.x and above

![Screenshot](5cc37afa-43d3-4364-b09f-7031976c2b08.jpeg)

## Branches:

* master - stable app release
* develop - development branch, merge your feature branches here

## Dependencies:

The project is using cocoapods for managing external libraries.

Install the pods

```
pod install
```

### Core Dependencies

* Firebase/Core
* Firebase/Auth
* Firebase/Database
* Firebase/Storage
* Firebase/Messaging

## Project structure:

* Models - post, comment and user model objects
* UserProfile - contains user profile controller, header and cell classes
* Login - sign up and log in controller classes
* Utils - protocols, extension and utility classes
* Home - home controller, post cell, comments controller and comment cell classes
* Camera - preview photo, custom animations and camera controller classes
* AddPhoto - share photo and photo selector classes
* Search - user search controller and cell classes
