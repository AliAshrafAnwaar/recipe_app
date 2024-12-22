import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/data/repo/main_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserProvider extends _$UserProvider {
  final repo = MainRepo();
  @override
  UserModel? build() {
    ref.keepAlive();
    return null;
  }

  Future<bool> signIn(String email, String password) async {
    final user = await repo.signIn(email, password);
    if (user != null) {
      state = user;
      return true;
    } else {
      return false;
    }
  }

  void signUp(String email, String password, String username) async {
    final user = await repo.signUp(email, password, username);
    state = user;
  }
}
