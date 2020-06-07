import 'dart:convert';

class User {
  final String username;
  bool isSelected = false;

  User({
    this.username,
    this.isSelected,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'isSelected': isSelected,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      username: map['username'],
      isSelected: false,
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'User(username: $username, isSelected: $isSelected)';
}
