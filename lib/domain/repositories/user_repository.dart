import '../../data/models/login_response_model.dart';
import '../../data/services/login_service.dart';
import '../../utils/constants.dart';

class UserRepository {
  final UserService service;

  UserRepository(this.service);

  Future<LoginResponse> login(
      String email, String password, String role) async {
    final response = await service.login(email, password, role);
    logger.i("Repository received response: $response");

    try {
      return LoginResponse.fromJson(response);
    } catch (e) {
      logger.e("Error while parsing response into UserModel: $e");
      rethrow;
    }
  }
}
