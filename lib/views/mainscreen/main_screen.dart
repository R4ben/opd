import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_bottom_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomBottomBar(
        navigationShell: navigationShell,
      ),
    );
  }

//   Widget _carousel() => BlocBuilder<CategoryBloc, CategoryState>(
//         builder: (context, state) {
//           if (state is CategoryLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is CategoryLoaded) {
//             return ProductCarousel(
//               category: state.categories,
//             );
//           } else {
//             return const Center(child: Text('Algo deu Errado tente de navo'));
//           }
//         },
//       );
}
