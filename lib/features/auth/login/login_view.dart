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
          backgroundColor: Colors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, LoginViewModel model) {
  return ListView(
    padding: EdgeInsets.all(24),
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Assets.images.icon.image(width: 250, height: 250),
      ),
      CustomTextField(
        controller: model.usernameController,
        label: 'Username',
        hintText: 'Masukkan Username',
        onChanged: model.updateUsername,
        errorText: model.usernameError,
      ),
      const SizedBox(height: 16.0),
      CustomTextField(
        controller: model.passwordController,
        obscureText: true,
        label: 'Password',
        hintText: 'Masukkan Password',
        textInputAction: TextInputAction.done,
        onChanged: model.updatePassword,
        errorText: model.passwordError,
      ),

      const SizedBox(height: 8.0),

      // Forgot Password
      Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            // TODO: panggil halaman / modal reset password
          },
          child: Text(
            'Lupa Password ?',
            style: AppFonts.medium.copyWith(
              color: AppColors.primary,
              fontSize: 12,
            ),
          ),
        ),
      ),

      const SizedBox(height: 24.0),
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
                        MaterialPageRoute(builder: (_) => const HomeView()),
                      );
                    }
                  }
                }
                : null,
        label: 'Login',
        isLoading: model.isBusy,
      ),
    ],
  );
}
