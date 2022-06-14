class User {
  int? id;
  String? password;
  String? lastLogin;
  bool? isSuperuser;
  String? username;
  String? firstName;
  String? lastName;
  bool? isStaff;
  bool? isActive;
  String? dateJoined;
  String? email;
  String? profilePic;
  String? contact;
  String? address;
  String? quote;
  String? latitude;
  String? longitude;
  bool? hasMembership;
  bool? renewMembership;
  bool? medic;

  User(
      {this.id,
      this.password,
      this.lastLogin,
      this.isSuperuser,
      this.username,
      this.firstName,
      this.lastName,
      this.isStaff,
      this.isActive,
      this.dateJoined,
      this.email,
      this.profilePic,
      this.contact,
      this.address,
      this.quote,
      this.latitude,
      this.longitude,
      this.hasMembership,
      this.renewMembership,
      this.medic});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    lastLogin = json['last_login'];
    isSuperuser = json['is_superuser'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    email = json['email'];
    profilePic = json['profile_pic'];
    contact = json['contact'];
    address = json['address'];
    quote = json['quote'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    hasMembership = json['has_membership'];
    renewMembership = json['renew_membership'];
    medic = json['medic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['last_login'] = this.lastLogin;
    data['is_superuser'] = this.isSuperuser;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['is_staff'] = this.isStaff;
    data['is_active'] = this.isActive;
    data['date_joined'] = this.dateJoined;
    data['email'] = this.email;
    data['profile_pic'] = this.profilePic;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['quote'] = this.quote;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['has_membership'] = this.hasMembership;
    data['renew_membership'] = this.renewMembership;
    data['medic'] = this.medic;
    return data;
  }
}
