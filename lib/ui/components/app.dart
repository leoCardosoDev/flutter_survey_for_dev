import 'package:flutter/material.dart';
import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(136, 14, 79, 1);
    const primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    const primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

    final ThemeData theme = ThemeData();

    return MaterialApp(
      title: "4Dev",
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        colorScheme: theme.colorScheme.copyWith(primary: primaryColor, secondary: primaryColor, background: Colors.white),
        textTheme: const TextTheme(
          headlineLarge: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, color: primaryColorDark,)
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColorLight,)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor)
          ),
          alignLabelWithHint: true
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: const ColorScheme.dark(primary: primaryColor),
          buttonColor: primaryColor,
          splashColor: primaryColorLight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        )
      ),
      home: const LoginPage()
    );
  }
}
