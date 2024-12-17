abstract class LoginRepository {

  Future<String> submitForm(Map<String, dynamic> data);
  Future<String> getRandomUser();

}