import 'package:flutter/material.dart';

import '../components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            const HeadlineLarge(text: 'Login'),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                      )
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                        )
                      ),
                      obscureText: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Entrar'.toUpperCase())
                  ),
                  TextButton.icon(
                    onPressed: (){}, 
                    icon: const Icon(Icons.person), 
                    label: const Text('Criar conta')
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
