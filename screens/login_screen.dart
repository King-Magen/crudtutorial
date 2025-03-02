import 'dart:convert';
import 'package:crudtutorial/api/users.dart';
import 'package:crudtutorial/values/app_colors.dart';
import 'package:crudtutorial/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:crudtutorial/utils/snackbar_helper.dart';
import 'package:crudtutorial/utils/shared_pref_utils.dart';
import '../components/app_text_form_field.dart';
import '../widgets/gradient_background.dart';
import '../utils/navigation_helper.dart';
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
  // if using logout sharedPreferences!.remove('token');

  login() async {
    setState(() => isLoading = true);
    fieldValidNotifier.value = false;
    var response = await ApiService.loginUser(
        int.parse(idnumberController.text), passwordController.text);
    setState(() => isLoading = false);

    if (response['status_code'] == 201) {
      var data = jsonEncode(response['data']);
      await SharedPrefUtils.setString('token', response['token']);
      await SharedPrefUtils.setString('data', data);
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

    if (idnumber.isNotEmpty && password.isNotEmpty) {
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
        if (Responsive.isMobile(context)) _buildMobileLayout(),
        if (Responsive.isTablet(context)) _buildTabletLayout(),
        if (Responsive.isDesktop(context)) _buildDesktopLayout(),
      ],
    ));
  }

  Widget _buildMobileLayout() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // const GradientBackground(
        //   children: [
        //     Text(
        //       AppStrings.signInToYourNAccount,
        //       style: AppTheme.titleLarge,
        //     ),
        //     SizedBox(height: 6),
        //     Text(AppStrings.signInToYourAccount,
        //         style: AppTheme.bodySmall),
        //   ],
        // ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DrawerHeader(
                  child: Image.asset("assets/logos/logo.png"),
                ),

                SizedBox(
                  height: 5,
                ),

                Text(
                  "Maintenance And Repair System",
                  style: TextStyle(
                    fontSize: 20, // Text size
                    fontWeight: FontWeight.bold, // Bold text
                    color: Colors.black87, // Text color
                  ),
                ),
                Text("Keep your data safe", style: AppTheme.bodySmall),

                SizedBox(
                  height: 30,
                ),

                // idnumber
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Container(
      color: Colors.amber[300],
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      color: const Color.fromARGB(255, 6, 115, 238),
    );
  }
}
