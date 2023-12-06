import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:survey_for_dev/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  late LoginPresenter presenter;
  late StreamController<String?> emailErrorController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String?>();
    when(() => presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
  });

  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);
    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

   testWidgets('Should call validate with correct email', (WidgetTester tester) async {
    await loadPage(tester);
    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('E-mail'), email);
    verify(() => presenter.validateEmail(email));
  });

   testWidgets('Should call validate with correct password', (WidgetTester tester) async {
    await loadPage(tester);
    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(() => presenter.validatePassword(password));
  });

   testWidgets('Should presenter error if email is invalid', (WidgetTester tester) async {
    await loadPage(tester);
    emailErrorController.add('any error');
    await tester.pump();
    expect(find.text('any error'), findsOneWidget);
  });

   testWidgets('Should presenter no error if email is valid', (WidgetTester tester) async {
    await loadPage(tester);
    emailErrorController.add(null);
    await tester.pump();
    expect(find.descendant(of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text)), findsOneWidget);
  });
}
