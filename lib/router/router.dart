import 'package:auto_route/auto_route.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/home_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/'),
  ];

}
