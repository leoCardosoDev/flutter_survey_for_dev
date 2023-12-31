import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({ super.key });

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      child: StreamBuilder<String?>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Senha',
              icon: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
              ),
              errorText: snapshot.data?.isEmpty == true  ? null : snapshot.data
            ),
            obscureText: true,
            onChanged: presenter.validatePassword,
          );
        }
      ),
    );
  }
}
