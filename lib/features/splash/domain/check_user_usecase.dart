import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckUserUseCase {
  Future<bool> call() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
