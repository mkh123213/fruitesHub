import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
import 'package:ecommercefruiteshub/core/services/google_auth_sevice.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthService {
  Future deleteUser();
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> signInWithApple();
  Future<User> updateUserNameAndEmail({
    required String name,
    required String email,
    required String currentPassword,
  });

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
}

class FirebaseAuthService implements AuthService {
  @override
  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}",
      );
      if (e.code == 'weak-password') {
        throw CustomException(message: 'الرقم السري ضعيف جداً.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(message: "email_already_in_use".tr());
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: "network_request_failed".tr());
      } else if (e.code == 'operation-not-allowed') {
        throw CustomException(message: "operation_not_allowed".tr());
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: "invalid_email".tr());
      } else {
        throw CustomException(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        );
      }
    } catch (e) {
      log(
        "Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}",
      );

      throw CustomException(
        message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
      );
    }
  }

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}",
      );
      if (e.code == 'user-not-found') {
        throw CustomException(message: "invalid_credential".tr());
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: "invalid_credential".tr());
      } else if (e.code == 'invalid-credential') {
        throw CustomException(message: "invalid_credential".tr());
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: "invalid_credential".tr());
      } else if (e.code == 'user-disabled') {
        throw CustomException(message: "user_disabled".tr());
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: "network_request_failed".tr());
      } else {
        throw CustomException(message: "some_thing_went_error".tr());
      }
    } catch (e) {
      log(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}",
      );

      throw CustomException(message: "some_thing_went_error".tr());
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    // Step 1: Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  @override
  Future<User> signInWithFacebook() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final LoginResult loginResult = await FacebookAuth.instance.login(
      nonce: nonce,
    );
    OAuthCredential facebookAuthCredential;

    if (Platform.isIOS) {
      switch (loginResult.accessToken!.type) {
        case AccessTokenType.classic:
          final token = loginResult.accessToken as ClassicToken;
          facebookAuthCredential = FacebookAuthProvider.credential(
            token.authenticationToken!,
          );
          break;
        case AccessTokenType.limited:
          final token = loginResult.accessToken as LimitedToken;
          facebookAuthCredential = OAuthCredential(
            providerId: 'facebook.com',
            signInMethod: 'oauth',
            idToken: token.tokenString,
            rawNonce: rawNonce,
          );
          break;
      }
    } else {
      facebookAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );
    }

    return (await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    )).user!;
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider(
      "apple.com",
    ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

    return (await FirebaseAuth.instance.signInWithCredential(
      oauthCredential,
    )).user!;
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Updates the email and name of the currently signed in user.
  ///
  /// Re-authenticates the user first, then updates the email and name.
  ///
  /// Throws [FirebaseAuthException] if there is an error updating the user email and name.
  ///
  /// Throws [CustomException] if there is an error updating the user email and name.
  ///
  /// Returns the updated user if the operation is successful.
  ///
  /// Parameters:
  /*******  1c17d703-1e01-4435-a5bb-6887dcf5096e  *******/
  Future<User> updateUserNameAndEmail({
    required String name,
    required String email,
    required String currentPassword,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      print("Updating user email and name...");
      // Re-authenticate the user first
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );
      log("Updating user password... '${credential}'");

      // Reauthenticate with the credential
      await user.reauthenticateWithCredential(credential);

      // Now update the email and name
      await user.verifyBeforeUpdateEmail(email);
      // Mashara2$
      await user.updateDisplayName(name);
      await user.sendEmailVerification();

      print("##################################################");
      print("${user.email} + ");
      print(user.displayName);
      print(user.emailVerified);
      print(credential.accessToken);

      print("##################################################");

      return user;

      // Update display name if provided

      // Reload user info from Firebase
      // await user.reload();
      // print('User email and name updated successfully!');
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'invalid-credential':
          throw CustomException(message: "wrong_password".tr());
        case 'too-many-requests':
          throw CustomException(message: "too_many_requests".tr());
      }
      throw CustomException(message: "some_thing_went_error".tr());
    } catch (e) {
      print('Error updating user email and name: $e');
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();

      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);

      user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code} - ${e.message}');
      throw CustomException(message: "some_thing_went_error".tr());
    }
  }
}
