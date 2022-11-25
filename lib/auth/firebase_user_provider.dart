import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class WhatsRememberFirebaseUser {
  WhatsRememberFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

WhatsRememberFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<WhatsRememberFirebaseUser> whatsRememberFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<WhatsRememberFirebaseUser>(
      (user) {
        currentUser = WhatsRememberFirebaseUser(user);
        return currentUser!;
      },
    );
