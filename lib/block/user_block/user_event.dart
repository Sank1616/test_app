abstract class UserEvent {}

class LoginUser extends UserEvent {
  final String email;
  final String password;
  final String role;

  LoginUser(this.email, this.password, this.role);
}
