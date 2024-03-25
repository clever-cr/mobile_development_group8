import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:sharp_mind/components/button.dart';

import '../lib/pages/login.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class UserCredentialMock extends Mock implements UserCredential {}

void main() {
  group('Login Widget', () {
    testWidgets('signInWithGoogle success', (WidgetTester tester) async {
      final mockAuth = MockFirebaseAuth();
      final mockGoogleSignIn = MockGoogleSignIn();
      final mockGoogleSigninAcount = MockGoogleSignInAccount();
      final login = Login();

      when(mockGoogleSignIn.signIn())
          .thenAnswer((_) async => (mockGoogleSigninAcount));

      when(mockAuth.signInWithCredential(any))
          .thenAnswer((_) async => UserCredentialMock());

      await tester.pumpWidget(MaterialApp(home: login));

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      verify(mockGoogleSignIn.signIn()).called(1);
      verify(mockAuth.signInWithCredential(any)).called(1);
    });

    testWidgets('signInWithGoogle failure', (WidgetTester tester) async {
      final mockAuth = MockFirebaseAuth();
      final mockGoogleSignIn = MockGoogleSignIn();
      final login = Login();

      when(mockGoogleSignIn.signIn()).thenThrow(Exception('Sign-in error'));

      await tester.pumpWidget(MaterialApp(home: login));

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      verify(mockGoogleSignIn.signIn()).called(1);
    });
    testWidgets('signinWithEmailAndPassowrd success',
        (WidgetTester tester) async {
      final mockAuth = MockFirebaseAuth();
      final login = Login();
      final email = 'test@gmail.com';
      final passcode = 'password';

      when(mockAuth.signInWithEmailAndPassword(
              email: email, password: passcode))
          .thenAnswer((_) async => UserCredentialMock());

      when(mockAuth.signInWithEmailAndPassword(
              email: email, password: passcode))
          .thenAnswer((_) async => UserCredentialMock());

      await tester.pumpWidget(MaterialApp(home: login));

      await tester.enterText(find.byType(TextField).at(0), email);
      await tester.enterText(find.byType(TextField).at(1), passcode);

      await tester.tap(find.byType(Button));
      await tester.pumpAndSettle();

      verify(mockAuth.signInWithEmailAndPassword(
              email: email, password: passcode))
          .called(1);
    });
  });
}
