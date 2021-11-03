import 'package:intl/intl.dart' show DateFormat;
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;
  @Unique()
  String email;
  String firstname;
  String lastname;
  bool isloggedin;
  String? passwordhash;
  DateTime? createddatetimeutc;
  String get dateFormat =>
      DateFormat('MM/dd/yyyy hh:mm:ss').format(createddatetimeutc!);
  DateTime? modifieddatetimeutc;
  String? expireson;
  String? plan;

  User(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.isloggedin,
      required this.id});
}
