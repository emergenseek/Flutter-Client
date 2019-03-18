import 'package:scoped_model/scoped_model.dart';

class SOSModel extends Model {
  bool _notifyUsers = false;
  bool _displayLockscreenInfo = true;
  bool _sosActive = false;

  bool getSOSStatus() {
    return _sosActive;
  }
  bool getNotifyUsers() {
    return _notifyUsers;
  }
  bool getDisplayLockscreenInfo() {
    return _displayLockscreenInfo;
  }

  void activateSOS() {
    _sosActive = true;
    // Inform [Model] to rebuild dependent widgets
    notifyListeners();
  }
  void deactivateSOS() {
    _sosActive = false;
    // Inform [Model] to rebuild dependent widgets
    notifyListeners();
  }
  void toggleNotifyUsers() {
    _notifyUsers = !_notifyUsers;
    notifyListeners();
  }
  void toggleDisplayLockscreenInfo() {
    _displayLockscreenInfo = !_displayLockscreenInfo;
    notifyListeners();
  }
}