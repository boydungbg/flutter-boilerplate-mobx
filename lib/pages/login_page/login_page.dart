import 'package:mix_tube_application/stores/login_store/login_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();

  late LoginStore _loginStore;

  @override
  void initState() {
    super.initState();
    _loginStore = Provider.of<LoginStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _emailCtl,
                decoration: const InputDecoration(
                    label: Text('Email'),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordCtl,
                decoration: const InputDecoration(
                    label: Text('Password'),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(child: Builder(builder: (context) {
                    return ElevatedButton(
                        onPressed: () {
                          _loginStore.login(_emailCtl.text, _passwordCtl.text);
                        },
                        child: const Text('Sign In'));
                  }))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
