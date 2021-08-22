import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter_app_firebase/Auth/ui/reset_password_page.dart';
import 'package:flutter_app_firebase/Auth/ui/widgets/custom_textField.dart';
import 'package:flutter_app_firebase/global_widgets/custom_button.dart';
import 'package:flutter_app_firebase/servises/routes_helper.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static final routeName = 'login';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AuthProvider>(
      builder: (context, provider, x) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextfield('Email', provider.emailController),
            CustomTextfield('Password', provider.passwordController),
            CustomButton(provider.login, 'Login'),
            GestureDetector(
              onTap: () {
                RouteHelper.routeHelper.goToPage(ResetPasswordPage.routeName);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forget Password?',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

