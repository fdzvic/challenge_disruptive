import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitRepository {
 
}

final initRepositoryProvider = Provider.autoDispose<InitRepository>(
  (ref) => InitRepository(),
);