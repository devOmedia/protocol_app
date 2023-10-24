class Profile {
  String? fullName;
  String? email;
  String? birthDate;
  String? employmentType;
  String? shift;
  String? designation;
  String? alternativeName;
  String? address;
  String? phone;
  String? gender;
  String? bloodGroup;
  String? nid;
  String? drivingLicense;
  String? brithRegistration;
  String? emergencyContactPerson;
  String? emergencyContactRelationship;
  String? emergencyContact;
  String? formalPicture;
  String? profilePicture;
  String? fathersName;
  String? mothersName;

  Profile(
      {this.fullName,
      this.email,
      this.birthDate,
      this.employmentType,
      this.shift,
      this.designation,
      this.alternativeName,
      this.address,
      this.phone,
      this.gender,
      this.bloodGroup,
      this.nid,
      this.drivingLicense,
      this.brithRegistration,
      this.emergencyContactPerson,
      this.emergencyContactRelationship,
      this.emergencyContact,
      this.formalPicture,
      this.profilePicture,
      this.fathersName,
      this.mothersName});

  Profile.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    birthDate = json['birth_date'];
    employmentType = json['employment_type'];
    shift = json['shift'];
    designation = json['designation'];
    alternativeName = json['alternative_name'];
    address = json['address'];
    phone = json['phone'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    nid = json['nid'];
    drivingLicense = json['driving_license'];
    brithRegistration = json['brith_registration'];
    emergencyContactPerson = json['emergency_contact_person'];
    emergencyContactRelationship = json['emergency_contact_relationship'];
    emergencyContact = json['emergency_contact'];
    formalPicture = json['formal_picture'];
    profilePicture = json['profile_picture'];
    fathersName = json['fathers_name'];
    mothersName = json['mothers_name'];
  }
}
