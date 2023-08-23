import 'package:user_list/data/UserRepository';
import 'package:user_list/domain/user.dart';

class GenderFilteredUserUseCase {
  final UserRepository _userRepository;

  GenderFilteredUserUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<List<dynamic>> getMaleUsers(int count) async {
    final maleUsers = await _userRepository.fetchMaleUsers(count);
    return maleUsers;
  }

  Future<List<dynamic>> getFemaleUsers(int count) async {
    final femaleUsers = await _userRepository.fetchFemaleUsers(count);
    return femaleUsers;
  }
}
