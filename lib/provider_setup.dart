import 'package:pion_app/core/services/dio_service.dart';
import 'package:pion_app/core/services/pref_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:pion_app/core/api/auth_api.dart';

List<SingleChildWidget> independentServices = <SingleChildWidget>[
  //
  Provider<DioService>(create: (_) => DioService(PrefService())),
];

List<SingleChildWidget> globalServices = <SingleChildWidget>[
  //
];

List<SingleChildWidget> apiServices = <SingleChildWidget>[
  ProxyProvider<DioService, AuthApi>(update: (_, dioService, __) => AuthApi(dioService.dio)),
];

List<SingleChildWidget> appProviders = [...independentServices, ...globalServices, ...apiServices];
