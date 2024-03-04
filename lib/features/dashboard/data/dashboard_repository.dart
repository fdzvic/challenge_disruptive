import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardRepository {
 
}

final dashboardRepositoryProvider = Provider.autoDispose<DashboardRepository>(
  (ref) => DashboardRepository(),
);