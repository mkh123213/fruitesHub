import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:ecommercefruiteshub/core/connection/network_info.dart';
import 'package:ecommercefruiteshub/core/cubits/products_cubit/products_cubit.dart';
import 'package:ecommercefruiteshub/core/repos/orders_repo/orders_repo_impl.dart';
import 'package:ecommercefruiteshub/core/repos/orders_repo/orders_repo_interface.dart';
import 'package:ecommercefruiteshub/core/services/data_storage/data_storage.dart';
import 'package:ecommercefruiteshub/core/services/data_storage/suba_base_storage.dart';
import 'package:ecommercefruiteshub/core/services/auth_service.dart';
import 'package:ecommercefruiteshub/core/services/firestore_service.dart';

import 'package:ecommercefruiteshub/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:ecommercefruiteshub/features/auth/domain/repo_interface/auth_repo_interface.dart';
import 'package:ecommercefruiteshub/features/auth/domain/use_cases/sign_in_with_email_and_password.dart';
import 'package:ecommercefruiteshub/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:ecommercefruiteshub/features/auth/domain/use_cases/sign_up_with_email_and_password.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:ecommercefruiteshub/features/best_selling/data/data_source/best_selling_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/best_selling/data/repo_impl/best_selling_repo_impl.dart';
import 'package:ecommercefruiteshub/features/best_selling/domain/repo_interface/best_selling_repo_interface.dart';
import 'package:ecommercefruiteshub/features/best_selling/domain/use_cases/get_best_selling_products_use_case.dart';
import 'package:ecommercefruiteshub/features/cart/data/repo_impl/cart_repo_impl.dart';
import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_entity.dart';
import 'package:ecommercefruiteshub/features/cart/domain/repo_interface/cart_repo_interface.dart';
import 'package:ecommercefruiteshub/features/cart/domain/use_cases/add_item_to_cart_entity.dart';
import 'package:ecommercefruiteshub/features/cart/domain/use_cases/remove_item_from_cart_entity.dart';
import 'package:ecommercefruiteshub/features/cart/presentation/cubit/cubit/cart_entity_cubit.dart';
import 'package:ecommercefruiteshub/features/check_out/data/data_source/chech_out_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/check_out/data/repo_impl/chec_out_repo_impl.dart';
import 'package:ecommercefruiteshub/features/check_out/domain/repo_interface/order_repo_interface.dart';
import 'package:ecommercefruiteshub/features/check_out/domain/use_cases/add_order_to_databse_use_case.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/get_orders_use_case.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/cubit/check_out_cubit/check_out_cubit.dart';
import 'package:ecommercefruiteshub/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/home/data/repo_impl/home_repo_impl.dart';
import 'package:ecommercefruiteshub/features/home/domain/home_repo_interface/home_repo_interface.dart';
import 'package:ecommercefruiteshub/features/home/domain/use_cases/get_all_products_use_cse.dart';
import 'package:ecommercefruiteshub/features/products/data/data_source/product_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/products/data/repo_impl/products_repo_impl.dart';
import 'package:ecommercefruiteshub/features/products/domain/repo_interface/product_repo_interface.dart';
import 'package:ecommercefruiteshub/features/products/domain/us_cases/get_all_products_for_app_use_case.dart';
import 'package:ecommercefruiteshub/features/products/domain/us_cases/search_product_use_case.dart';
import 'package:ecommercefruiteshub/features/profile/data/data_source/main_profile_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/profile/domain/repo_interface/maim_profile_repo_interface.dart';
import 'package:ecommercefruiteshub/features/profile/data/repo_impl/main_profile_repo_impl.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/update_name_and_email_use_case.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/update_password_use_case.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/upload_image_use_case.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/cubit/cubit/main_profile_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetit() {
  //services
  getIt.registerSingleton(DataConnectionChecker());
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(getIt.get()));
  // services
  getIt.registerSingleton<DataBaseService>(FirestoreServices());
  getIt.registerSingleton<AuthService>(FirebaseAuthService());
  getIt.registerSingleton<DataStorage>(SubaBaseStorage());

  //dataSource
  getIt.registerSingleton(
    BestSellingRemoteDataSource(
      dataBaseService: getIt.get(),
      networkInfo: getIt.get(),
    ),
  );
  getIt.registerSingleton(
    HomeRemoteDataSource(
      dataBaseService: getIt.get(),
      networkInfo: getIt.get(),
    ),
  );
  getIt.registerSingleton(
    ProductRemoteDataSource(
      dataBaseService: getIt.get(),
      networkInfo: getIt.get(),
    ),
  );
  getIt.registerSingleton(
    CheckOutRemoteDataSource(
      dataBaseService: getIt.get(),
      networkInfo: getIt.get(),
    ),
  );
  getIt.registerSingleton(
    MainProfileRemoteDataSource(
      networkInfo: getIt.get(),
      authService: getIt.get(),
      dataBase: getIt.get(),
      dataStorage: getIt.get(),
    ),
  );
  getIt.registerSingleton(CartEntity(items: []));

  //repos
  getIt.registerSingleton<AuthRepoInterface>(
    AuthRepoImpl(
      authServiceInstance: getIt.get<AuthService>(),
      dataBaseSeviceInstance: getIt.get<DataBaseService>(),
    ),
  );
  getIt.registerSingleton<BestSellingRepoInterface>(
    BestSellingRepoImpl(bestSellingRemoteDataSource: getIt.get()),
  );
  getIt.registerSingleton<HomeRepoInterface>(
    HomeRepoImpl(homeDataSource: getIt.get()),
  );
  getIt.registerSingleton<ProductRepoInterface>(
    ProductsRepoImpl(productsRemoteDatqaSource: getIt.get()),
  );
  getIt.registerSingleton<CartRepoInterface>(
    CartRepoImpl(cartEntity: getIt.get()),
  );
  getIt.registerSingleton<CheckOutRepoInterface>(
    CheckOutRepoImpl(checkOutRemoteDataSource: getIt.get()),
  );
  // getIt.registerSingleton<OrderRepoInterface>(OrderRepoImpl(repo: getIt.get()));
  // getIt.registerSingleton<OrderRepoInterface>(OrderRepoImpl(repo: getIt.get()));

  getIt.registerSingleton<MainProfileRepoInterface>(
    MainProfileRepoImpl(remoteDataSource: getIt.get()),
  );

  //useCases
  getIt.registerSingleton(SignUpWithEmailAndPasswordUseCase(getIt.get()));

  getIt.registerSingleton(SignInWithGoogleUseCase(getIt.get()));
  getIt.registerSingleton(SignInWithEmailAndPasswordUseCase(repo: getIt.get()));
  getIt.registerSingleton(GetBestSellingProductsUseCase(repo: getIt.get()));
  getIt.registerSingleton(GetAllProductsUseCse(repo: getIt.get()));
  getIt.registerSingleton(GetAllProductsForAppUseCase(repo: getIt.get()));
  getIt.registerSingleton(AddItemToCartEntityUseCase(repo: getIt.get()));
  getIt.registerSingleton(RemoveItemFromCartEntity(repo: getIt.get()));
  getIt.registerSingleton(AddOrderToDatabseUseCase(repo: getIt.get()));
  getIt.registerSingleton(SearchProductUseCase(repo: getIt.get()));
  getIt.registerSingleton(GetOrdersTrackUseCase(repo: getIt.get()));
  getIt.registerSingleton(UploadImageUseCase(repo: getIt.get()));
  getIt.registerSingleton(UpdateNameAndEmailUseCase(repo: getIt.get()));
  getIt.registerSingleton(UpdatePasswordUseCase(repo: getIt.get()));

  //cubit
  getIt.registerFactory(
    () => SignInCubit(
      signInWithGoogleUseCase: getIt.get(),
      signInWithEmailAndPassword: getIt.get(),
    ),
  );
  getIt.registerFactory(
    () => ProductsCubit(
      searchProductUseCase: getIt.get(),
      getBestSellingProductsUseCase: getIt.get(),
      getAllProductsUseCse: getIt.get(),
      getAllProductsForAppUseCase: getIt.get(),
    ),
  );
  getIt.registerFactory(
    () => CartEntityCubit(
      addItemToCartEntityUseCase: getIt.get(),
      removeItemFromCartEntity: getIt.get(),
      cartEntity: getIt.get(),
    ),
  );
  getIt.registerFactory(() => CheckOutCubit(addOrderUseCase: getIt.get()));
  getIt.registerFactory(
    () => MainProfileCubit(
      getOrderTrackUseCase: getIt.get(),
      updatePasswordUseCase: getIt.get(),
      uploadImageUseCase: getIt.get(),
      updateNameAndEmailUseCase: getIt.get(),
    ),
  );
}
