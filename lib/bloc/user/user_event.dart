abstract class UserEvent {}

class LoadUserById extends UserEvent
{
  LoadUserById();
}
class LogoutRequested extends UserEvent {}
