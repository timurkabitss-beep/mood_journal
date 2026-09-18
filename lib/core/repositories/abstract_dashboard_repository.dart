import 'dashboard_state.dart';
abstract class AbstractDashboardRepository {
  DashboardState loadDashboardState({required bool isFirstLaunch});
}