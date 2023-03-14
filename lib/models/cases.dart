class Cases {
   String? id;
  final String name;
  final String gender;
  final int age;
  final String address;
  final String city;
  final String country;
  final String status;
   String? updated;

  Cases({  this.id, required this.name, required this.gender, required this.age, required this.address, required this.city, required this.country, required this.status,  this.updated });

  factory Cases.fromJson(Map<String, dynamic> json) {
return Cases(
id: json['id'],
name: json['name'],
gender: json['gender'],
age: json['age'],
address: json['address'],
city: json['city'],
country: json['country'],
status: json['status'],
updated: json['updated'],
);
  }

  @override
  String toString() {
    return 'Cases{id: $id, name: $name, age: $age}';
  }
}