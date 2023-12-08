import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import './components/components.dart';
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
                  child: Provider(
                    create: (_) => widget.presenter,
                    child: Form(child: Column(
                      children: [
                        const EmailInput(),
                        const PasswordInput(),
                        const LoginButton(),
                        TextButton.icon(
                          onPressed: (){}, 
                          icon: const Icon(Icons.person), 
                          label: const Text('Criar conta')
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
