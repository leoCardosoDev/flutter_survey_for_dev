import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Builder(
        builder: (BuildContext context) {
          widget.presenter.isLoadingStream.listen((isLoading){
            isLoading ? showLoading(context) : hideLoading(context);
          });
          widget.presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context, error);
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginHeader(),
                const HeadlineLarge(text: 'Login'),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(child: Column(
                    children: [
                      StreamBuilder<String?>(
                        stream: widget.presenter.emailErrorStream,
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
                            onChanged: widget.presenter.validateEmail,
                          );
                        }
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 32),
                        child: StreamBuilder<String?>(
                          stream: widget.presenter.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                icon: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                                ),
                                errorText: snapshot.data?.isEmpty == true  ? null : snapshot.data
                              ),
                              obscureText: true,
                              onChanged: widget.presenter.validatePassword,
                            );
                          }
                        ),
                      ),
                      StreamBuilder<bool?>(
                        stream: widget.presenter.isFormValidStream,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: snapshot.data == true ? widget.presenter.auth : null,
                            child: Text('Entrar'.toUpperCase())
                          );
                        }
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
          );
        }
      ),
    );
  }
}
