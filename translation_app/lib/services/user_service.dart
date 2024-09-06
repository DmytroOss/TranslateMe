import 'package:firebase_database/firebase_database.dart';

import '../../models/user.dart';

class UserService {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  createUser({required UserDTO user}) async {
    var obj = dbRef.child('/User').push();
    await obj.set(user.toJson());
    return obj;
  }

  Future<User> retrieveUserByEmail(String email) async {
    List<User> users = await retrieveAllUsers();
    return users.where((element) => element.userDTO!.email == email).first;
  }

  Future<List<User>> retrieveAllUsers() async {
    List<User> users = [];
    DataSnapshot data = await dbRef.child("/User").get();
    for (var element in data.children) {
      UserDTO dataValue = UserDTO.fromJson(element.value as Map);
      users.add(User(key: element.key, userDTO: dataValue));
    }

    return users;
  }
}
