import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../login_presenter.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({ super.key });

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String?>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'E-mail',
            icon: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
            ),
            errorText: snapshot.data?.isEmpty == true  ? null : snapshot.data
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      }
    );
  }
}
