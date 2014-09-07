part of boxy;

class UserMode {
  
  final String _value;
  
  const UserMode._internal(this._value);
  
  String toString() => _value;
  
  static const HANDLE_MODE = const UserMode._internal('SELECT_MODE');
  static const CONNECT_MODE = const UserMode._internal('CONNECT_MODE');
}