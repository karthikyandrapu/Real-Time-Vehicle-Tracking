import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
//google sign In

  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally,lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//   Future<UserCredential> signInWithFacebook() async {
//     final LoginResult loginResult = await FacebookAuth.instance.login();
//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(loginResult.accessToken!.token);
//     return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//   }
// }
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Start the Facebook login process
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Check if the login was successful
      if (loginResult.status == LoginStatus.success) {
        // Get the Facebook access token
        final AccessToken accessToken = loginResult.accessToken!;

        // Create an OAuthCredential using the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.token);

        // Sign in to Firebase using the Facebook credential
        return await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      } else if (loginResult.status == LoginStatus.cancelled) {
        // Handle login cancellation
        print('Facebook login cancelled');
        return null;
      } else {
        // Handle login failure
        print('Facebook login failed');
        return null;
      }
    } catch (e) {
      // Handle any exceptions
      print('Error signing in with Facebook: $e');
      return null;
    }
  }
}
//   Future<String?> signInWithFacebook() async {
//     try {
//       final _instance = FacebookAuth.instance;
//       final FirebaseAuth _auth = FirebaseAuth.instance;
//       final result = await _instance.login(permissions: ['email']);
//       if (result.status == LoginStatus.success) {
//         final OAuthCredential credential =
//             FacebookAuthProvider.credential(result.accessToken!.token);
//         final a = await _auth.signInWithCredential(credential);
//         await _instance.getUserData().then((userData) async {
//           await _auth.currentUser!.updateEmail(userData['email']);
//         });
//         return null;
//       } else if (result.status == LoginStatus.cancelled) {
//         return 'Login cancelled';
//       } else {
//         return 'Error';
//       }
//     } catch (e) {
//       return e.toString();
//     }
//   }
// }