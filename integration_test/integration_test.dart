import 'package:awesome_quotes/awesome_quotes.dart';
import 'package:awesome_quotes_exercise/main.dart';
import 'package:awesome_quotes_exercise/models/favorites_model.dart';
import 'package:awesome_quotes_exercise/pages/favorites_page.dart';
import 'package:awesome_quotes_exercise/pages/quote_page.dart';
import 'package:awesome_quotes_exercise/services/quotes_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

final defaultQuote = Quote("Testing quote", "Testing author");

class FakeQuotesService extends QuotesService {
  Quote getRandomQuote() {
    return defaultQuote;
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const kLiKeButtonKey = Key('like-button');
  const kNextButtonKey = Key('next-button');
  const kQuoteTextKey = Key('quote-text');
  const kAuthorTextKey = Key('author-text');
  const kQuotePageKey = Key('quote-page');
  const kFavoritesPageKey = Key('favorites-page');

  group('Tests with real quotes service', () {
    testWidgets('Shows quote page, hit next and get a new quote', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => FavoritesModel()),
            Provider<QuotesService>(create: (context) => QuotesService()),
          ],
          child: const MyApp(),
        ),
      );

      expect(find.byType(QuotePage), findsOneWidget);

      // buttons
      expect(find.byKey(kLiKeButtonKey), findsOneWidget);
      expect(find.byKey(kNextButtonKey), findsOneWidget);

      // get initial quote
      Text quoteText = tester.widget(find.byKey(kQuoteTextKey));
      String? quote = quoteText.data;
      expect(quote, isNotNull);
      Text authorText = tester.widget(find.byKey(kAuthorTextKey));
      String? author = authorText.data;
      expect(author, isNotNull);

      // tap the next button
      await tester.tap(find.byKey(kNextButtonKey));
      await tester.pump();

      Text quoteText2 = tester.widget(find.byKey(kQuoteTextKey));
      String? quote2 = quoteText2.data;
      expect(quote2, isNotNull);

      if (quote == quote2) {
        fail('It should have shown a different quote after touching "next"');
      }
    });
  });

  group('Tests with fake quotes service', () {

    testWidgets('Shows quote page', (WidgetTester tester) async {
      await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => FavoritesModel()),
              Provider<QuotesService>(create: (context) => FakeQuotesService()),
            ],
            child: const MyApp(),
          )
      );

      expect(find.byType(QuotePage), findsOneWidget);

      // buttons
      expect(find.byKey(kLiKeButtonKey), findsOneWidget);
      expect(find.byKey(kNextButtonKey), findsOneWidget);

      final Finder buttonFinder = find.byKey(kLiKeButtonKey);
      final Finder textInsideButtonFinder = find.descendant(of: buttonFinder, matching: find.byType(Text));
      Text textInsideButton = tester.widget(textInsideButtonFinder);
      expect(textInsideButton.data, "Like");

      // bottom navigation bar
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byKey(kQuotePageKey), findsOneWidget);
      expect(find.byKey(kFavoritesPageKey), findsOneWidget);

      // quote
      expect(find.text('Testing quote'), findsOneWidget);
      expect(find.text('- Testing author -'), findsOneWidget);
    });

    testWidgets('Navigate to favorites and back to quote', (WidgetTester tester) async {
      await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => FavoritesModel()),
              Provider<QuotesService>(create: (context) => FakeQuotesService()),
            ],
            child: const MyApp(),
          )
      );

      expect(find.byType(QuotePage), findsOneWidget);

      // bottom navigation bar
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byKey(kQuotePageKey), findsOneWidget);
      expect(find.byKey(kFavoritesPageKey), findsOneWidget);

      await tester.tap(find.byKey(kFavoritesPageKey));
      await tester.pump();
      expect(find.byType(FavoritesPage), findsOneWidget);

      // bottom navigation bar should be the same on Favorites Page
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byKey(kQuotePageKey), findsOneWidget);
      expect(find.byKey(kFavoritesPageKey), findsOneWidget);

      // it should be empty
      expect(find.byType(ListTile), findsNothing);

      await tester.tap(find.byKey(kQuotePageKey));
      await tester.pump();
      expect(find.byType(QuotePage), findsOneWidget);
    });

    testWidgets('Mark as favorite and navigate to favorites', (WidgetTester tester) async {
      await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => FavoritesModel()),
              Provider<QuotesService>(create: (context) => FakeQuotesService()),
            ],
            child: const MyApp(),
          )
      );

      expect(find.byType(QuotePage), findsOneWidget);

      // check that the model is empty
      expect(FavoritesModel.instance.favorites, equals([]));

      // buttons
      expect(find.byKey(kLiKeButtonKey), findsOneWidget);

      await tester.tap(find.byKey(kLiKeButtonKey));

      // check that the model now includes the favorite quote
      expect(FavoritesModel.instance.favorites, equals([defaultQuote]));

      await tester.tap(find.byKey(kFavoritesPageKey));
      await tester.pump();
      expect(find.byType(FavoritesPage), findsOneWidget);

      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text('Testing quote'), findsOneWidget);
    });
  });
}
