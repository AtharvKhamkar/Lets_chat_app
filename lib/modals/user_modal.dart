class User {
/*
{
  "_id": "670ae17b15ebeb0c34ffeb04",
  "username": "atharvkhamkar"
} 
*/

  String? Id;
  String? username;

  User({
    this.Id,
    this.username,
  });
  User.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    username = json['username']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['username'] = username;
    return data;
  }
}
