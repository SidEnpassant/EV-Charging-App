// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:chargerrr/core/theme/app_theme.dart';
// import 'package:chargerrr/core/utils/app_constants.dart';
// import 'package:chargerrr/presentation/screens/auth/login/login_controller.dart';
// import 'package:chargerrr/presentation/widgets/custom_button.dart';
// import 'package:chargerrr/presentation/widgets/custom_text_field.dart';

// class LoginScreen extends GetView<LoginController> {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: controller.formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 40),

//                 // Logo and Title
//                 Center(
//                   child: SvgPicture.asset(
//                     'assets/images/logo.svg',
//                     width: 80,
//                     height: 80,
//                   ),
//                 ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),

//                 const SizedBox(height: 24),

//                 Text(
//                   AppConstants.appName,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: AppTheme.primaryColor,
//                   ),
//                 ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

//                 const SizedBox(height: 8),

//                 Text(
//                   AppConstants.appTagline,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

//                 const SizedBox(height: 48),

//                 // Login Form
//                 Text(
//                   'Login',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ).animate().fadeIn(delay: 800.ms, duration: 600.ms),

//                 const SizedBox(height: 24),

//                 // Email Field
//                 CustomTextField(
//                       controller: controller.emailController,
//                       labelText: 'Email',
//                       hintText: 'Enter your email',
//                       keyboardType: TextInputType.emailAddress,
//                       prefixIcon: Icons.email_outlined,
//                       validator: controller.validateEmail,
//                     )
//                     .animate()
//                     .fadeIn(delay: 1000.ms, duration: 600.ms)
//                     .slideX(begin: 0.1, end: 0),

//                 const SizedBox(height: 16),

//                 // Password Field
//                 CustomTextField(
//                       controller: controller.passwordController,
//                       labelText: 'Password',
//                       hintText: 'Enter your password',
//                       obscureText: true,
//                       prefixIcon: Icons.lock_outline,
//                       validator: controller.validatePassword,
//                     )
//                     .animate()
//                     .fadeIn(delay: 1200.ms, duration: 600.ms)
//                     .slideX(begin: 0.1, end: 0),

//                 const SizedBox(height: 8),

//                 // Forgot Password
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {},
//                     child: const Text('Forgot Password?'),
//                   ),
//                 ).animate().fadeIn(delay: 1400.ms, duration: 600.ms),

//                 const SizedBox(height: 24),

//                 // Error Message
//                 Obx(
//                   () => controller.errorMessage.value != null
//                       ? Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.red.shade50,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.red.shade200),
//                           ),
//                           child: Text(
//                             controller.errorMessage.value!,
//                             style: TextStyle(color: Colors.red.shade800),
//                           ),
//                         )
//                       : const SizedBox.shrink(),
//                 ),

//                 const SizedBox(height: 24),

//                 // Login Button
//                 Obx(
//                       () => CustomButton(
//                         text: 'Login',
//                         isLoading: controller.isLoading.value,
//                         onPressed: controller.login,
//                       ),
//                     )
//                     .animate()
//                     .fadeIn(delay: 1600.ms, duration: 600.ms)
//                     .slideY(begin: 0.1, end: 0),

//                 const SizedBox(height: 24),

//                 // Register Link
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Don\'t have an account?',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                     TextButton(
//                       onPressed: controller.navigateToRegister,
//                       child: const Text('Register'),
//                     ),
//                   ],
//                 ).animate().fadeIn(delay: 1800.ms, duration: 600.ms),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:chargerrr/core/theme/app_theme.dart';
import 'package:chargerrr/core/utils/app_constants.dart';
import 'package:chargerrr/presentation/screens/auth/login/login_controller.dart';
import 'package:chargerrr/presentation/widgets/custom_button.dart';
import 'package:chargerrr/presentation/widgets/custom_text_field.dart';
import 'package:permission_handler/permission_handler.dart'; // added

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  Future<void> _requestLocationPermission() async {
    // Request permission only if not granted
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Run after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestLocationPermission();
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Logo and Title
                Center(
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 80,
                    height: 80,
                  ),
                ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),

                const SizedBox(height: 24),

                Text(
                  AppConstants.appName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

                const SizedBox(height: 8),

                Text(
                  AppConstants.appTagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

                const SizedBox(height: 48),

                // Login Form
                Text(
                  'Login',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 800.ms, duration: 600.ms),

                const SizedBox(height: 24),

                // Email Field
                CustomTextField(
                      controller: controller.emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      validator: controller.validateEmail,
                    )
                    .animate()
                    .fadeIn(delay: 1000.ms, duration: 600.ms)
                    .slideX(begin: 0.1, end: 0),

                const SizedBox(height: 16),

                // Password Field
                CustomTextField(
                      controller: controller.passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      obscureText: true,
                      prefixIcon: Icons.lock_outline,
                      validator: controller.validatePassword,
                    )
                    .animate()
                    .fadeIn(delay: 1200.ms, duration: 600.ms)
                    .slideX(begin: 0.1, end: 0),

                const SizedBox(height: 8),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ).animate().fadeIn(delay: 1400.ms, duration: 600.ms),

                const SizedBox(height: 24),

                // Error Message
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
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(height: 24),

                // Login Button
                Obx(
                      () => CustomButton(
                        text: 'Login',
                        isLoading: controller.isLoading.value,
                        onPressed: controller.login,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 1600.ms, duration: 600.ms)
                    .slideY(begin: 0.1, end: 0),

                const SizedBox(height: 24),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    TextButton(
                      onPressed: controller.navigateToRegister,
                      child: const Text('Register'),
                    ),
                  ],
                ).animate().fadeIn(delay: 1800.ms, duration: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
