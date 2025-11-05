// import 'dart:developer';

// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleAuthService {
//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
//   bool _initialized = false;

//   Future<void> initialize() async {
//     if (!_initialized) {
//       await _googleSignIn.initialize();
//       _initialized = true;
//     }
//   }

//   Future<GoogleSignInAccount> signIn() async {
//     await initialize();
//     try {
//       // authenticate instead of signIn
//       final account = await _googleSignIn.authenticate();
//       return account;
//     } on GoogleSignInException catch (e) {
//       // handle specific errors
//       rethrow;
//     } catch (e) {
//       log("Exception in GoogleAuthService.signIn: ${e.toString()}");
//       rethrow;
//     }
//   }

//   Future<GoogleSignInAccount?> signInSilently() async {
//     await initialize();
//     try {
//       final result = _googleSignIn.attemptLightweightAuthentication();
//       if (result is Future<GoogleSignInAccount?>) {
//         return await result;
//       } else {
//         return result as GoogleSignInAccount?;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
// }
