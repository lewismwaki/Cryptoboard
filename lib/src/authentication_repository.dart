import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'models/auth_model.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

/// Thrown during the sign in with facebook process if a failure occurs.
class LoginWithFacebookFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// Throw during the email verification process if a failure occurs.
class SendForgotPasswordEmailFailure implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  AuthenticationRepository({firebase_auth.FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn, Facebook})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  /// Stream of [AuthenticatedUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AuthenticatedUser.empty] if the user is not authenticated.
  Stream<AuthenticatedUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? AuthenticatedUser.empty : firebaseUser.toUser;
    });
  }

  // Sign Up with e-mail
  // Creates a new user with the provided [email] and [password].
  Future<void> signUpWithEmailAndPassword({@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('user emai created');

      try {
        if (!_firebaseAuth.currentUser.emailVerified) {
          print('trying to email verify email');

          var actionCodeSettings = firebase_auth.ActionCodeSettings(
            url: 'https://www.cryptoboard/?email=${_firebaseAuth.currentUser.email}',
            androidPackageName: 'com.mwakicodes.cryptoboard',
            androidInstallApp: true,
            androidMinimumVersion: "12",
            handleCodeInApp: true,
            dynamicLinkDomain: "cryptoboard.page.link",
          );
          await _firebaseAuth.currentUser.sendEmailVerification(actionCodeSettings);
          print('email verif. sent');
        }
      } on firebase_auth.FirebaseAuthException catch (e) {
        print(e);
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // Sign In with Google
  // Starts the Sign In with Google Flow.
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } catch (_) {
      print(_);
      throw LogInWithGoogleFailure();
    }
  }

  //Sign In with Facebook
  //Stars the Sign In with Facebook flow.
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final AccessToken accessToken = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.token);

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (_) {
      print(_);
      throw LoginWithFacebookFailure();
    }
  }

  // Sign in with E-mail
  // Signs in with the provided [email] and [password].
  Future<void> logInWithEmailAndPassword({@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // Sign Out
  // Signs out the current user which will emit [User.empty] from the [user] Stream.
  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } on Exception {
      throw LogOutFailure();
    }
  }

  // delete account
  // deletes users firebase and google accounts completeley
  Future<void> deleteAccount() async {
    try {
      await Future.wait([_firebaseAuth.currentUser.delete(), _googleSignIn.disconnect()]);
    } catch (_) {
      print(_);
      throw LogOutFailure();
    }
  }

  // send password reset email
  // for reseting forgotten password
  Future<void> sendForgotPasswordEmail({@required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      // _firebaseAuth.pass
    } on Exception {
      throw SendForgotPasswordEmailFailure();
    }
  }
}

//user details to firebase User
extension on firebase_auth.User {
  AuthenticatedUser get toUser {
    return AuthenticatedUser(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
