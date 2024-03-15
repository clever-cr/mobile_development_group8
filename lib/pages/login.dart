import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sharp_mind/components/button.dart';
import 'package:sharp_mind/components/text_field.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Future<bool> signInWithGoogle() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      print(userCredential.user!.displayName);
      return true;
    } catch (error) {
      // Print errors during Google Sign-in
      print('Error during Google Sign-in: $error');
      return false;
    }
  }

  Future<bool> signinWithEmailAndPassowrd(String email, String password) async {
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("user is from password $user");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final String? error = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (error != null) Text(error, style: TextStyle(color: Colors.red)),
            Field(
              hintText: 'Username',
              controller: usernameController,
              decoration: InputDecoration(),
            ),
            SizedBox(height: 20),
            Field(
              hintText: 'Password',
              controller: passwordController,
              decoration: InputDecoration(),
            ),
            SizedBox(height: 20),
            Button(
              buttonText: 'Login',
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;
                final isAuth =
                    await signinWithEmailAndPassowrd(username, password);
                isAuth
                    ? Navigator.pushNamed(context, '/quiz')
                    : Navigator.pushNamed(context, '/',
                        arguments:
                            "Invalid email or password \n Please try again");
              },
            ),
            Text('or continue with'),
            SizedBox(
              width: 200,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final isAuth = await signInWithGoogle();
                      isAuth
                          ? Navigator.pushNamed(context, '/quiz')
                          : Navigator.pushNamed(context, '/',
                              arguments:
                                  "Invalid email or password \n Please try again");
                    },
                    child: Container(
                      child: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('Sign-in with Google'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
