import 'package:firebase_auth/firebase_auth.dart';
//TODO допиши функцию удаления аккаунта
class AuthRepository {
  AuthRepository._();
  static final AuthRepository instance = AuthRepository._();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password
    );
  }

  Future<UserCredential> login(String email, String password) async{
    return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  }

  Future<UserCredential?> reauthenticate(String password) async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null){
      final credential =  EmailAuthProvider.credential(email: user.email!, password: password);
      return await user.reauthenticateWithCredential(credential);
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
  Future<void> deleted() async{

  }
  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();


}