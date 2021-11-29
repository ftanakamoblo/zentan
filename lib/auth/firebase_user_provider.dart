import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Zenta3FirebaseUser {
  Zenta3FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Zenta3FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Zenta3FirebaseUser> zenta3FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Zenta3FirebaseUser>((user) => currentUser = Zenta3FirebaseUser(user));
