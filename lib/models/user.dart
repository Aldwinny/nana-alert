/// User model: Now idk how a user model should be when SSO is permitted but I think I should look into it.
class User {
  int? id;
  String? username;

  // TODO: Fillup the rest of the variables

  Map<String, dynamic> toMap() {
    // TODO: implement toArray function
    return {"name": "john doe"};
  }

  User? createFrom({required Map<String, dynamic> map}) {
    // TODO: return a routine object based on the mapping retrieved from firebase
    return null;
  }
}
