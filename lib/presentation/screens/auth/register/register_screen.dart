import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chargerrr/presentation/screens/auth/register/register_controller.dart';
import 'package:chargerrr/presentation/widgets/custom_button.dart';
import 'package:chargerrr/presentation/widgets/custom_text_field.dart';
import 'package:chargerrr/core/theme/app_theme.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                SvgPicture.asset(
                      'assets/images/logo.svg',
                      height: 100,
                      width: 100,
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(
                      begin: -0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOutQuad,
                    ),
                const SizedBox(height: 24),
                Text(
                      'Join Chargerrr',
                      style: Get.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    )
                    .animate()
                    .fadeIn(delay: 200.ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      delay: 200.ms,
                      duration: 600.ms,
                      curve: Curves.easeOutQuad,
                    ),
                const SizedBox(height: 8),
                Text(
                  'Find and share EV charging stations',
                  style: Get.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 32),
                CustomTextField(
                      controller: controller.nameController,
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      prefixIcon: Icons.person_outline,
                      validator: controller.validateName,
                    )
                    .animate()
                    .fadeIn(delay: 500.ms)
                    .slideX(
                      begin: -0.1,
                      end: 0,
                      delay: 500.ms,
                      duration: 500.ms,
                    ),
                const SizedBox(height: 16),
                CustomTextField(
                      controller: controller.emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                    )
                    .animate()
                    .fadeIn(delay: 600.ms)
                    .slideX(
                      begin: -0.1,
                      end: 0,
                      delay: 600.ms,
                      duration: 500.ms,
                    ),
                const SizedBox(height: 16),
                CustomTextField(
                      controller: controller.passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      validator: controller.validatePassword,
                    )
                    .animate()
                    .fadeIn(delay: 700.ms)
                    .slideX(
                      begin: -0.1,
                      end: 0,
                      delay: 700.ms,
                      duration: 500.ms,
                    ),
                const SizedBox(height: 16),
                CustomTextField(
                      controller: controller.confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      validator: controller.validateConfirmPassword,
                    )
                    .animate()
                    .fadeIn(delay: 800.ms)
                    .slideX(
                      begin: -0.1,
                      end: 0,
                      delay: 800.ms,
                      duration: 500.ms,
                    ),
                const SizedBox(height: 24),
                Obx(
                  () => controller.errorMessage.value != null
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            controller.errorMessage.value!,
                            style: TextStyle(color: Colors.red.shade800),
                            textAlign: TextAlign.center,
                          ),
                        ).animate().shake()
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 24),
                Obx(
                      () => CustomButton(
                        text: 'Create Account',
                        onPressed: controller.register,
                        isLoading: controller.isLoading.value,
                        icon: Icons.person_add_outlined,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 900.ms)
                    .slideY(
                      begin: 0.1,
                      end: 0,
                      delay: 900.ms,
                      duration: 500.ms,
                    ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Get.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: controller.navigateToLogin,
                      child: Text(
                        'Sign In',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 1000.ms),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
