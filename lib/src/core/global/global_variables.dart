import 'package:app_receitas/src/feactures/auth/domain/entities/user_entity.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.instance;

class Global {
  static const String dnsApi = 'http://192.168.18.4:8080';
  static String token = '';
  static UserEntity? user;
}
