import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/views/login_form.dart';
import 'package:flutter_application_1/widgets/auth_check.dart';
import 'package:provider/src/provider.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            appBar: AppBar(
              //backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                // DateFormat.yMMMMd().format(selectedDate),
                'Redefinir senha',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    // obscureText: true,
                    validator: (value) {
                      if (value == null) {
                        return 'Informe seu email!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await context
                            .read<AuthServices>()
                            .resetPassword(email.text);

                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: Text('Redefinir senha'),
                                  content: Text(
                                      'Enviamos um email para você escolher uma nova senha!'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok')),
                                  ],
                                ));

                        //await context.read<HumoresRepository>().readHumores();
                      } on AuthException catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.message)));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Continuar',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
