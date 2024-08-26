# Flutter exercise - awesome quotes

## Goal

The goal of this exercise is to develop a Flutter application that displays inspirational quotes.

![demonstração](./docs/awesome-quotes-demo.gif)

## Exercise

This repository has already been created with the expected project structure; you only need to create the necessary code within the provided files. Some code has already been created to customize the application’s theme.

Two test files, test/widget_test.dart and integration_test/integration_test.dart, are also included, allowing you to run a series of widget/integration tests. You should not modify these files. However, you should use them to locally validate that you have correctly implemented the application.

Additionally, these tests will be executed every time you push to the repository[^1].

These tests assume that some widgets have specific keys associated with them. See the image below to identify these keys:

![chaves dos widgets](./docs/screenshot.png)

You should create the application considering these requirements until it:
* Has the appearance and behavior shown in the demonstration above
* Passes the widget and integration tests

## Assumptions

This exercise assumes that you understand what integration tests are and know how to use Provider. If you haven’t done so yet, watch the video [Developing with flutter widgets - part 5](https://www.youtube.com/watch?v=22WyA_NVkLk).

It also assumes that you understand the Observer/Observable pattern and how to use it in Flutter. If you haven’t done so yet, watch the video [Developing with flutter widgets - part 6](https://www.youtube.com/watch?v=6n9qzEjSlzs).

## Technical tips

To obtain the “inspirational” quotes, you will use the [awesome_quotes](https://pub.dev/packages/awesome_quotes) library. This library is already included in the pubspec.yaml file.

For navigation, you should use a [NavigationBar](https://api.flutter.dev/flutter/material/NavigationBar-class.html). The navigation should be implemented in the
`MainPage` widget, which you should create in the `main_page.dart` file.

You will need to implement two classes: `FavoritesModel` and `QuotesService` (the classes already exist but are empty). These classes should not be Singletons, as that would hinder their testability. 
Instead, they should be instantiated in main() and injected into the application via a `MultiProvider`. The `Provider` library is already included in the pubspec.yaml file.

Since these two classes are injected, you should never instantiate them in `QuotePage` and `FavoritesPage`. Instead, you should use  
`context.read()` to obtain them.

The `FavoritesModel` class should include a `favorites` property containing a list of `Quote` objects (this class is included in the "awesome_quotes" library). To ensure encapsulation, this property should be read-only (hint: use a getter that returns an `UnmodifiableListView`) and you should include an `addFavorite(Quote quote)` method. Additionally, this class should be observable, and calls to `addFavorite(Quote quote)` should notify observers that the object's state has changed.

The `QuotesService` class should include a `getRandomQuote()` method that returns a random quote. This class simply calls the "awesome_quotes" library. It may seem like an unnecessary class (why not have the widget call the library directly?), but it allows tests to use a `FakeQuoteService` that always returns the same quote. See the first lines of `widget_test.dart` to understand what we are referring to.

Note that there are some quotes that are quite large (with many characters). You should ensure that the quote text always fits on the screen without overflowing.

If you notice, the widget test code is very similar to the integration test code. However, widget tests run much faster, so we recommend running those tests instead of the integration tests. Nevertheless, there may be errors that are difficult to diagnose in widget tests which become more obvious in integration tests since you can see what is being tested on the emulator.

[^1]: For performance reasons, at the moment, integration tests are not being run on GitHub.

