import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/custom-widgets/custom_textfield.dart';
import 'package:social_media_app/custom-widgets/myButton.dart';
import 'package:social_media_app/helper/helper_functions.dart';
import 'package:social_media_app/pages/homepage.dart';
import 'package:social_media_app/pages/registerPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Future<void> login() async {
      //show loading circle
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      //make sure password match

      //try creating user
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false,
          );
        }
      } on FirebaseAuthException catch (e) {
        print(e);
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(Icons.flutter_dash,
                  size: 80, color: Theme.of(context).colorScheme.tertiary),
              const SizedBox(height: 25),
              //app name

              Text(
                'N o t T w i t t e r',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
              // email textfield4
              const SizedBox(height: 25),
              CustomTextField(
                  hintext: 'Email',
                  obscureText: false,
                  controller: emailController),
              const SizedBox(height: 10),
              CustomTextField(
                  hintext: 'Password',
                  obscureText: true,
                  controller: passwordController),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  )
                ],
              ),
              MyButton(
                text: 'Log in',
                onTap: login,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ));
                    },
                    child: Text(
                      ' Register Here',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
