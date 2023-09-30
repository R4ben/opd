import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';

class AddressPage extends StatelessWidget {
  AddressPage({
    super.key,
  });
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Editar Endereço',
      //     style: Theme.of(context).textTheme.bodyMedium,
      //   ),
      // ),
      body: Stack(
        children: [
          Positioned(
            top: 20.h * 3,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () =>
                      context.read<NavigationBloc>().add(NavigateToMainPage()),
                  child: AppIcons(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    iconSize: 24.r,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'Editar Endereço',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Positioned(
            top: 20.h * 5,
            left: 20.w,
            right: 20.w,
            child: AppTextField(
              textController: _controller,
              hintText: "Endereco",
              icon: Icons.abc,
              validator: (p0) {},
              onChanged: (value) {},
            ),
          )
        ],
      ),
    );
  }
}
