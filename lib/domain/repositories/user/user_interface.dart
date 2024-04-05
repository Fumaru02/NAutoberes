abstract class IUserRepository {
  Future<void> onSubmittedForm(String lat, String long, String homeServiceName,
      String homeServiceAddress, String homeServiceSkill);
}
