class UserDetailsModel {
  String? id;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? v;

  UserDetailsModel({
    this.id,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'UserDetailsModel(id: $id, username: $username, email: $email, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] == null ? null : json['createdAt'] as String,
      updatedAt: json['updatedAt'] == null ? null : json['updatedAt'] as String,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': username,
        'email': email,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}
