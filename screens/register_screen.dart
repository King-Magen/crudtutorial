import 'package:crudtutorial/api/users.dart';
import 'package:crudtutorial/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:crudtutorial/utils/snackbar_helper.dart';

import '../components/app_text_form_field.dart';
import '../widgets/gradient_background.dart';
import '../utils/navigation_helper.dart';
import '../values/app_constants.dart';
import '../values/app_regex.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController idnumberController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController permissionController;
  late final TextEditingController nameController;
  late final TextEditingController middlenameController;
  late final TextEditingController lastnameController;
  late final TextEditingController positionController;
  late final TextEditingController addressController;
  late final TextEditingController numberController;

  String? selectedPosition;
  bool isLoading = false;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  register() async {
    setState(() => isLoading = true);
    fieldValidNotifier.value = false;

    var response = await ApiService.createUser(
        int.parse(idnumberController.text),
        passwordController.text,
        permissionController.text,
        nameController.text,
        middlenameController.text,
        lastnameController.text,
        positionController.text,
        addressController.text,
        numberController.text);
    setState(() => isLoading = false);

    if (response['status_code'] == 201) {
      SnackbarHelper.showSnackBar(response['message'],
          backgroundColor: AppColors.successResponse);
      NavigationHelper.pushReplacementNamed(AppRoutes.login);
    } else {
      SnackbarHelper.showSnackBar(response['message'],
          backgroundColor: AppColors.errorResponse);
      Future.delayed(const Duration(milliseconds: 2500), () {
        fieldValidNotifier.value = true;
      });
    }
  }

  void initializeControllers() {
    idnumberController = TextEditingController()
      ..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListener);
    permissionController = TextEditingController()
      ..addListener(controllerListener);
    nameController = TextEditingController()..addListener(controllerListener);
    middlenameController = TextEditingController()
      ..addListener(controllerListener);
    lastnameController = TextEditingController()
      ..addListener(controllerListener);
    positionController = TextEditingController()
      ..addListener(controllerListener);
    addressController = TextEditingController()
      ..addListener(controllerListener);
    numberController = TextEditingController()..addListener(controllerListener);
  }

  void disposeControllers() {
    idnumberController.dispose();
    permissionController.dispose();
    nameController.dispose();
    middlenameController.dispose();
    lastnameController.dispose();
    positionController.dispose();
    addressController.dispose();
    numberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListener() {
    final idnumber = idnumberController.text;
    final permission = permissionController.text;
    final name = nameController.text;
    final middlename = middlenameController.text;
    final lastname = lastnameController.text;
    final position = positionController.text;
    final address = addressController.text;
    final number = numberController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (idnumber.isEmpty &&
        permission.isEmpty &&
        name.isEmpty &&
        middlename.isEmpty &&
        lastname.isEmpty &&
        position.isEmpty &&
        address.isEmpty &&
        number.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) return;

    if (AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword)) {
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
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                )),
              ),
            ),

          //main content
          ListView(
            children: [
              const GradientBackground(
                children: [
                  Text(AppStrings.register, style: AppTheme.titleLarge),
                  SizedBox(height: 4),
                  Text(AppStrings.createYourAccount, style: AppTheme.bodySmall),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //id number
                      AppTextFormField(
                        autofocus: true,
                        labelText: AppStrings.idnumber,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterName
                              : value.length < 4
                                  ? AppStrings.invalidName
                                  : null;
                        },
                        controller: idnumberController,
                      ),

                      //password
                      ValueListenableBuilder<bool>(
                        valueListenable: passwordNotifier,
                        builder: (_, passwordObscure, __) {
                          return AppTextFormField(
                            obscureText: passwordObscure,
                            controller: passwordController,
                            labelText: AppStrings.password,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return value!.isEmpty
                                  ? AppStrings.pleaseEnterPassword
                                  : AppConstants.passwordRegex.hasMatch(value)
                                      ? null
                                      : AppStrings.invalidPassword;
                            },
                            suffixIcon: Focus(
                              /// If false,
                              ///
                              /// disable focus for all of this node's descendants
                              descendantsAreFocusable: false,

                              /// If false,
                              ///
                              /// make this widget's descendants un-traversable.
                              // descendantsAreTraversable: false,
                              child: IconButton(
                                onPressed: () =>
                                    passwordNotifier.value = !passwordObscure,
                                style: IconButton.styleFrom(
                                  minimumSize: const Size.square(48),
                                ),
                                icon: Icon(
                                  passwordObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      //confirm password
                      ValueListenableBuilder(
                        valueListenable: confirmPasswordNotifier,
                        builder: (_, confirmPasswordObscure, __) {
                          return AppTextFormField(
                            labelText: AppStrings.confirmPassword,
                            controller: confirmPasswordController,
                            obscureText: confirmPasswordObscure,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return value!.isEmpty
                                  ? AppStrings.pleaseReEnterPassword
                                  : AppConstants.passwordRegex.hasMatch(value)
                                      ? passwordController.text ==
                                              confirmPasswordController.text
                                          ? null
                                          : AppStrings.passwordNotMatched
                                      : AppStrings.invalidPassword;
                            },
                            suffixIcon: Focus(
                              /// If false,
                              ///
                              /// disable focus for all of this node's descendants.
                              descendantsAreFocusable: false,

                              /// If false,
                              ///
                              /// make this widget's descendants un-traversable.
                              // descendantsAreTraversable: false,
                              child: IconButton(
                                onPressed: () => confirmPasswordNotifier.value =
                                    !confirmPasswordObscure,
                                style: IconButton.styleFrom(
                                  minimumSize: const Size.square(48),
                                ),
                                icon: Icon(
                                  confirmPasswordObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // permission
                      AppTextFormField(
                        labelText: AppStrings.permission,
                        controller: permissionController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterPermission
                              : null;
                        },
                      ),

                      // name
                      AppTextFormField(
                        labelText: AppStrings.name,
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterName
                              : null;
                        },
                      ),

                      // middlename
                      AppTextFormField(
                        labelText: AppStrings.middlename,
                        controller: middlenameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterMiddleName
                              : null;
                        },
                      ),

                      // lastname
                      AppTextFormField(
                        labelText: AppStrings.lastname,
                        controller: lastnameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterLastName
                              : null;
                        },
                      ),

                      // position
                      AppTextFormField(
                        labelText: AppStrings.position,
                        controller: positionController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterPosition
                              : null;
                        },
                      ),

                      // address
                      AppTextFormField(
                        labelText: AppStrings.address,
                        controller: addressController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterAddress
                              : null;
                        },
                      ),

                      // number
                      AppTextFormField(
                        labelText: AppStrings.number,
                        controller: numberController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterNumber
                              : null;
                        },
                      ),

                      // submit button
                      ValueListenableBuilder(
                        valueListenable: fieldValidNotifier,
                        builder: (_, isValid, __) {
                          return FilledButton(
                            onPressed: isValid || !isLoading
                                ? () async {
                                    await register();
                                  }
                                : null,
                            child: const Text(AppStrings.register),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.iHaveAnAccount,
                    style: AppTheme.bodySmall.copyWith(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () =>
                        NavigationHelper.pushReplacementNamed(AppRoutes.login),
                    child: const Text(AppStrings.login),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
