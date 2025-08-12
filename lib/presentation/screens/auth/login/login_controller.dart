import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chargerrr/core/routes/app_pages.dart';
import 'package:chargerrr/domain/usecases/auth/login_usecase.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;
  
  LoginController(this._loginUseCase);
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final isLoading = false.obs;
  final errorMessage = RxnString(null);
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  
  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    errorMessage.value = null;
    isLoading.value = true;
    
    try {
      await _loginUseCase(emailController.text, passwordController.text);
      Get.offAllNamed(Routes.home);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  
  void navigateToRegister() {
    Get.toNamed(Routes.register);
  }
}