import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/services/api.dart';

mixin ProfileModel on Model {
  String _userId;

  String _first_name;
  String _last_name;
  String _blood_type;
  int _age;
  Map<dynamic, dynamic> _primary_residence;
  int _phone_pin;
  String _email_address;
  String _phone_number;

  // Return true once request has been fulfilled
  // signals FutureBuilder to build
  Future<bool> getProfileInfo() async {
    var info = await getProfile(_userId);
    _first_name = info.first_name;
    _last_name = info.last_name;
    _blood_type = info.blood_type;
    _age = info.age;
    _primary_residence = info.primary_residence;
    _phone_pin = info.phone_pin;
    _email_address= info.email_address;
    _phone_number = info.phone_number;

    return true;
  }

  getFirstName() { return _first_name; }
  getLastName() { return _last_name; }
  getBloodType() { return _blood_type; }
  getAge() { return _age; }
  getPrimaryResidence() { return _primary_residence; }
  getPhonePin() { return _phone_pin; }
  getEmail() { return _email_address; }
  getPhoneNumber() { return _phone_number; }

  setProfileUserId(String newUserId) { _userId = newUserId; }

  setFirstName(String newFirstName) { _first_name = newFirstName; }
  setLastName(String newLastName) { _last_name = newLastName; }
  setBloodType(String newBloodType) { _blood_type = newBloodType; }
  setAge(int newAge) { _age = newAge; }
  setPrimaryResidence(Map<dynamic, dynamic> newAddress) { _primary_residence = newAddress; }
  setPhonePin(int newPin) { _phone_pin = newPin; }
  setEmail(String newEmail) { _email_address = newEmail; }
  setPhoneNumber(String newPhoneNum) { _phone_number = newPhoneNum; }

  updateProfileInfo(Map<String, dynamic> profile) {
    updateProfile(profile, _userId);
  }
}
