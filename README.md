This package includes standard methods and functions to use in various projects of CitroByte company, where I'm working in.

## Features

Set of extensions for String, DateTime, Num, and some others.

Abstract class with states of loading process from back-end. It also includes number of functions to provide a result to streams. The result may be simple, DTO or a model converted from DTO.
A model called ErrorDTO is standard DTO, that passed in the company's back-end with code 401 to show what was wrong.

UI folder includes:
- animation of a widget with gradient,
- decorations for containers to simplify their creation,
- builder of like-iOS dialogs,
- builder of a widget with an image loaded by a link

LinksLauncher is a class to open http(s) links and to make calls.

HttpOverrides is a class that is necessary to show images for Android Apps.

Helper to get and set values in Shared Preferences.

## Usage

To use this package add in pubspec.yaml below dependencies the following lines:

```
dependencies:
  ...
  citro_byte_lib:
    git:
      url: https://github.com/a-balakmet/citro_byte_lib
      path: 
```

HttpOverrides has to be initialized starting any project that includes Android application.
Below is an example to init HttpOverrides.

```
import 'dart:io' show HttpOverrides, Platform;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      HttpOverrides.global = MyHttpOverrides();
    }
    super.initState();
  }
```

All other classes, mixins, extensions mey be called directly.

## Additional information

This package may be used by anyone absolutely free. 
It also may be copied, modified, corrected, amended or added with anything which may be necessary.
