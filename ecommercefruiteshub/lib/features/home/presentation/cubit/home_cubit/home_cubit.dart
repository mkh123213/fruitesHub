// import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
// import 'package:ecommercefruiteshub/features/home/domain/use_cases/get_all_products_use_cse.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit({required this.getAllProductsUseCse}) : super(HomeInitial());
//   final GetAllProductsUseCse getAllProductsUseCse;

//   Future<void> getAllProducts() async {
//     emit(AllProductsLoading());
//     final result = await getAllProductsUseCse();
//     result.fold(
//       (failure) => emit(AllProductsFailure(message: failure.message)),
//       (products) => emit(AllProductsLoaded(products: products)),
//     );
//   }
// }
