import 'package:gazprom_test/core/failure.dart';
import 'package:gazprom_test/core/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gazprom_test/features/auth/domain/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  Future<Result<void>> call(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return const Success(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const NoSuchUserFailure().asError;
      } else if (e.code == 'wrong-password') {
        return const WrongPasswordFailure().asError;
      } else if (e.code == 'invalid-email') {
        return const WrongEmailFormatFailure().asError;
      } else if (e.code == 'network-request-failed') {
        return const InternetFailure().asError;
      }

      return const UnknownFailure().asError;
    }
  }
}
