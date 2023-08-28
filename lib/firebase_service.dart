import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBypViEUfFA5AEHxhzbbpaSkr4vwz96ES0",
          authDomain: "betibaproj.firebaseapp.com",
          projectId: "betibaproj",
          storageBucket: "betibaproj.appspot.com",
          messagingSenderId: "1060233110280",
          appId: "1:1060233110280:web:f1b1f0a8865d2f8eb302bd"
      ),
    );
  }
}
