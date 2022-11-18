import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // true -> go home page
  // false -> go login page
  bool isAlreadyAuthenticated() {
    return _auth.currentUser != null;
  }

  Future<void> signOutGoogleUser() async {
    await _googleSignIn.signOut();
  }

  Future<void> signOutFirebaseUser() async {
    await _auth.signOut();
  }

  Future<void> signOutFull() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> createNewUser(email, password) async {
    print("Receivded ${email}");
    print("Receivded ${password}");

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future <bool> signInWithEmail(email, password) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      print(_auth.currentUser!.uid);
      await _createUserCollectionFirebase(_auth.currentUser!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
    }
    return false;
  }

  Future<void> signInWithGoogle() async {
    //Google sign in
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;

    print(">> User email:${googleUser.email}");
    print(">> User name:${googleUser.displayName}");
    print(">> User photo:${googleUser.photoUrl}");

    // credenciales de usuario autenticado con Google
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // firebase sign in con credenciales de Google
    final authResult = await _auth.signInWithCredential(credential);

    // Extraer token**
    // User user = authResult.user!;
    // final firebaseToken = await user.getIdToken();
    // print("user fcm token:${firebaseToken}");

    // crear tabla user en firebase cloudFirestore y agregar valor fotoListId []
    await _createUserCollectionFirebase(_auth.currentUser!.uid);
  }

  Future<void> _createUserCollectionFirebase(String uid) async {
    var userDoc = await FirebaseFirestore.instance
        .collection("users_pantry")
        .doc(uid)
        .get();
    // Si no exite el doc, lo crea con valor default lista vacia
    if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection("users_pantry").doc(uid).set(
        {"ingredients": [], "email": "", "name": "", "picture": ""},
      );
    } else {
      // Si ya existe el doc return
      return;
    }
  }
}
