import 'package:pion_app/core/api/feed_api.dart';
import 'package:pion_app/core/api/financial_api.dart';
import 'package:pion_app/core/api/learning_api.dart';
import 'package:pion_app/core/api/organization_api.dart';
import 'package:pion_app/core/api/social_api.dart';
import 'package:pion_app/core/api/vision_api.dart';
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
  ProxyProvider<DioService, FinancialApi>(
    update: (_, dioService, __) => FinancialApi(dioService.dio),
  ),
  ProxyProvider<DioService, OrganizationApi>(
    update: (_, dioService, __) => OrganizationApi(dioService.dio),
  ),
  ProxyProvider<DioService, LearningApi>(
    update: (_, dioService, __) => LearningApi(dioService.dio),
  ),
  ProxyProvider<DioService, SocialApi>(
    update: (_, dioService, __) => SocialApi(dioService.dio),
  ),
  ProxyProvider<DioService, VisionApi>(
    update: (_, dioService, __) => VisionApi(dioService.dio),
  ),
  ProxyProvider<DioService, FeedApi>(
    update: (_, dioService, __) => FeedApi(dioService.dio),
  ),
];

List<SingleChildWidget> appProviders = [
  ...independentServices,
  ...globalServices,
  ...apiServices,
];
