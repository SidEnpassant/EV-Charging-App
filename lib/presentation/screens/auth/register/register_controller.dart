import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chargerrr/core/routes/app_pages.dart';
import 'package:chargerrr/domain/usecases/auth/register_usecase.dart';

class RegisterController extends GetxController {
  final RegisterUseCase _registerUseCase;
  
  RegisterController(this._registerUseCase);
  
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final isLoading = false.obs;
  final errorMessage = RxnString(null);
  
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
  
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
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
  
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  
  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    errorMessage.value = null;
    isLoading.value = true;
    
    try {
      await _registerUseCase(
        emailController.text,
        passwordController.text,
        nameController.text,
      );
      Get.offAllNamed(Routes.home);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  
  void navigateToLogin() {
    Get.back();
  }
}