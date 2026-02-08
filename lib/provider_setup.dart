import 'package:pion_app/core/services/dio_service.dart';
import 'package:pion_app/core/services/pref_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:pion_app/core/api/auth_api.dart';
import 'package:pion_app/core/api/information_api.dart';

List<SingleChildWidget> independentServices = <SingleChildWidget>[
  Provider<DioService>(create: (_) => DioService(PrefService())),
];

List<SingleChildWidget> globalServices = <SingleChildWidget>[
  //
];

List<SingleChildWidget> apiServices = <SingleChildWidget>[
  ProxyProvider<DioService, AuthApi>(
    update: (_, dioService, __) => AuthApi(dioService.dio),
  ),
  ProxyProvider<DioService, InformationApi>(
    update: (_, dioService, __) => InformationApi(dioService.dio),
  ),
];

List<SingleChildWidget> appProviders = [
  ...independentServices,
  ...globalServices,
  ...apiServices,
];
