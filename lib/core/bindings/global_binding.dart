import 'package:get/get.dart';

import '../../App/data/data_sources/local_data_source.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalDataSource>(
      () => LocalDataSourceImpl(),
      fenix: true,
    );
  }
}
