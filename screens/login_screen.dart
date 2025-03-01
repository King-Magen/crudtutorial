import 'package:crudtutorial/api/users.dart';
import 'package:crudtutorial/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crudtutorial/utils/helpers/snackbar_helper.dart';
import 'package:crudtutorial/values/app_regex.dart';

import '../components/app_text_form_field.dart';
import '../resources/resources.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_constants.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController idnumberController;
  late final TextEditingController passwordController;
  bool isLoading = false;

  login() async {
    setState(() => isLoading = true);
    fieldValidNotifier.value = false;
    var response = await ApiService.loginUser(
        int.parse(idnumberController.text), passwordController.text);
    setState(() => isLoading = false);

    print(response);
    if (response['status_code'] == 201) {
      SnackbarHelper.showSnackBar(response['message'],
          backgroundColor: AppColors.successResponse);
      NavigationHelper.pushReplacementNamed(AppRoutes.homeScreen);
    } else {
      SnackbarHelper.showSnackBar(response['message'],
          backgroundColor: AppColors.errorResponse);
      fieldValidNotifier.value = true;
    }
  }

  void initializeControllers() {
    idnumberController = TextEditingController()
      ..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    idnumberController.dispose();
    passwordController.dispose();
  }

  void controllerListener() {
    final idnumber = idnumberController.text;
    final password = passwordController.text;

    if (idnumber.isEmpty && password.isEmpty) return;

    if (idnumber.isNotEmpty) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),

        // main content
        ListView(
          padding: EdgeInsets.zero,
          children: [
            const GradientBackground(
              children: [
                Text(
                  AppStrings.signInToYourNAccount,
                  style: AppTheme.titleLarge,
                ),
                SizedBox(height: 6),
                Text(AppStrings.signInToYourAccount, style: AppTheme.bodySmall),
              ],
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //idnumber
                    AppTextFormField(
                      controller: idnumberController,
                      labelText: AppStrings.idnumber,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterIdNumber
                            : null;
                      },
                    ),

                    //password
                    ValueListenableBuilder(
                      valueListenable: passwordNotifier,
                      builder: (_, passwordObscure, __) {
                        return AppTextFormField(
                          obscureText: passwordObscure,
                          controller: passwordController,
                          labelText: AppStrings.password,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPassword
                                : null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () =>
                                passwordNotifier.value = !passwordObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              passwordObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),

                    //forgot password
                    TextButton(
                      onPressed: () {},
                      child: const Text(AppStrings.forgotPassword),
                    ),

                    const SizedBox(height: 20),

                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return FilledButton(
                          onPressed: isValid
                              ? () async {
                                  await login();
                                }
                              : null,
                          child: const Text(AppStrings.login),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade200)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            AppStrings.orLoginWith,
                            style: AppTheme.bodySmall.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade200)),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            // icon: SvgPicture.asset(Vectors.google, width: 14),
                            label: const Text(
                              AppStrings.google,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            // icon: SvgPicture.asset(Vectors.facebook, width: 14),
                            label: const Text(
                              AppStrings.facebook,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.doNotHaveAnAccount,
                  style: AppTheme.bodySmall.copyWith(color: Colors.black),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.register,
                  ),
                  child: const Text(AppStrings.register),
                ),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}
