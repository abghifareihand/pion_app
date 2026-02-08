import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pion_app/core/api/auth_api.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/features/auth/login/login_view_model.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/home/home_view.dart';
import 'package:pion_app/ui/shared/custom_button.dart';
import 'package:pion_app/ui/shared/custom_snackbar.dart';
import 'package:pion_app/ui/shared/custom_text_field.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      model: LoginViewModel(authApi: Provider.of<AuthApi>(context)),
      onModelReady: (LoginViewModel model) => model.initModel(),
      onModelDispose: (LoginViewModel model) => model.disposeModel(),
      builder: (BuildContext context, LoginViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

// Widget _buildBody(BuildContext context, LoginViewModel model) {
//   return ListView(
//     padding: EdgeInsets.all(24),
//     children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 32),
//         child: Assets.images.logo.image(width: 200, height: 200),
//       ),
// CustomTextField(
//   controller: model.usernameController,
//   label: 'Username',
//   hintText: 'Masukkan Username',
//   onChanged: model.updateUsername,
//   errorText: model.usernameError,
// ),
// const SizedBox(height: 16.0),
// CustomTextField(
//   controller: model.passwordController,
//   obscureText: true,
//   label: 'Password',
//   hintText: 'Masukkan Password',
//   textInputAction: TextInputAction.done,
//   onChanged: model.updatePassword,
//   errorText: model.passwordError,
// ),
//       const SizedBox(height: 24.0),
//       Button.filled(
//         onPressed:
//             model.isFormValid
//                 ? () async {
//                   await model.login();
//                   if (context.mounted) {
//                     if (model.error) {
//                       CustomSnackbar.showError(context, model.message);
//                     }
//                     if (model.success) {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (_) => const HomeView()),
//                       );
//                     }
//                   }
//                 }
//                 : null,
//         label: 'Login',
//         isLoading: model.isBusy,
//       ),
//     ],
//   );
// }

Widget _buildBody(BuildContext context, LoginViewModel model) {
  return Stack(
    children: [
      // Logo
      Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),

      // Card Login
      Container(
        margin: EdgeInsets.fromLTRB(
          20,
          MediaQuery.of(context).size.height * 0.15,
          20,
          20,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Login',
                style: AppFonts.bold.copyWith(
                  color: AppColors.black,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Login untuk mengakses layanan dan informasi seru bersama SP PION',
                style: AppFonts.regular.copyWith(
                  color: AppColors.darkGrey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32.0),
              CustomTextField(
                prefixIcon: Icon(Icons.person_outline_outlined),
                controller: model.usernameController,
                label: 'Username',
                hintText: 'Masukkan Username',
                onChanged: model.updateUsername,
                errorText: model.usernameError,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                prefixIcon: Icon(Icons.lock_outline),
                controller: model.passwordController,
                obscureText: true,
                label: 'Password',
                hintText: 'Masukkan Password',
                textInputAction: TextInputAction.done,
                onChanged: model.updatePassword,
                errorText: model.passwordError,
              ),

              const SizedBox(height: 32.0),
              Button.filled(
                onPressed:
                    model.isFormValid
                        ? () async {
                          await model.login();
                          if (context.mounted) {
                            if (model.error) {
                              CustomSnackbar.showError(context, model.message);
                            }
                            if (model.success) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const HomeView(),
                                ),
                              );
                            }
                          }
                        }
                        : null,
                label: 'Login',
                isLoading: model.isBusy,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
