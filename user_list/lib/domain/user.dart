class User {
  final String gender;
  final String name;
  final String location;
  final String email;
  final String dob;
  final String phone;
  final String cell;
  final String picture;

  User({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.dob,
    required this.phone,
    required this.cell,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final location = json['location'];
    final dob = json['dob'];

    return User(
      gender: json['gender'],
      name: '${name['title']} ${name['first']} ${name['last']}',
      location: '${location['street']['number']} ${location['street']['name']}, ${location['city']}, ${location['state']}, ${location['country']}',
      email: json['email'],
      dob: dob['date'],
      phone: json['phone'],
      cell: json['cell'],
      picture: json['picture']['large'],
    );
  }
}


