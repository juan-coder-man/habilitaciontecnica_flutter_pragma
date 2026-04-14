/// Cliente HTTP para la API de Fake Store con respaldo en DummyJSON.
///
/// No depende de Flutter. Los resultados se exponen como
/// `Either<ApiFailure, T>` ([dartz](https://pub.dev/packages/dartz)).
library;

export 'src/failures/api_failure.dart';
export 'src/fake_store_api_client.dart';
export 'src/models/fake_store_demo_data_model.dart';
export 'src/models/sourced_data_model.dart';
export 'src/models/store_cart_model.dart';
export 'src/models/store_product_model.dart';
export 'src/models/store_user_model.dart';
