import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sharp_mind/components/button.dart';
import 'package:sharp_mind/components/text_field.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Future<void> signInWithGoogle() async {
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
      return null;
    } catch (error) {
      // Print errors during Google Sign-in
      print('Error during Google Sign-in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Field(
              hintText: 'Username',
              controller: TextEditingController(),
              decoration: InputDecoration(),
            ),
            SizedBox(height: 20),
            Field(
              hintText: 'Password',
              controller: TextEditingController(),
              decoration: InputDecoration(),
            ),
            SizedBox(height: 20),
            Button(
              buttonText: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
            ),
            Text('or continue with'),
            Container(
              width: 200,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                      Navigator.pushNamed(context, '/quiz');
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
