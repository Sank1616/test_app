import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/utils/constants.dart';
import 'package:test_app/views/home_views/vendor_home_view.dart';
import 'package:test_app/views/widgets/appButton.dart';
import 'package:test_app/views/widgets/app_text_field.dart';

import '../../block/user_block/user_block.dart';
import '../../block/user_block/user_event.dart';
import '../../block/user_block/user_state.dart';
import '../../data/services/login_service.dart';
import '../../domain/repositories/user_repository.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVendorSelected = true;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => UserBloc(UserRepository(UserService())),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserLoaded) {
                final role = state.user.data?.user?.role.toString();
                if (role == 'vendor') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => VendorHomeView(
                              userId: state.user.data?.user?.userId ?? "",
                            )),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const CustomScrollView()),
                  );
                }
              } else if (state is UserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: deviceWidth * 0.9,
                  height: deviceHeight,
                  child: BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state is UserLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Welcome, ${state.user.data?.user?.name}')),
                        );
                      } else if (state is UserError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${state.message}')),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/user.png',
                            width: deviceWidth * 0.25,
                          ),
                          h10,
                          Text(
                            "Log In",
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text("Please Login to Continue"),
                          SizedBox(height: deviceHeight * 0.05),


                          SizedBox(
                            width: deviceWidth * 0.5,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  _buildTabView(
                                    label: 'Vendor',
                                    isSelected: isVendorSelected,
                                    onTap: () {
                                      setState(() => isVendorSelected = true);
                                    },
                                  ),
                                  _buildTabView(
                                    label: 'Customer',
                                    isSelected: !isVendorSelected,
                                    onTap: () {
                                      setState(() => isVendorSelected = false);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: deviceHeight * 0.05),

                          AppTextField(
                            controller: emailController,
                            hint: 'Enter Id',
                            prefixIcon: Icons.person,
                          ),
                          h15,
                          AppTextField(
                            controller: passwordController,
                            hint: 'Enter Password',
                            prefixIcon: Icons.password,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          h20,

                          state is UserLoading
                              ? const CircularProgressIndicator()
                              : AppButton(
                                  label: 'Login',
                                  onClick: () {
                                    final email = emailController.text.trim();
                                    final password =
                                        passwordController.text.trim();
                                    final role = isVendorSelected
                                        ? "vendor"
                                        : "customer";

                                    if (email.isEmpty || password.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Enter email and password')),
                                      );
                                      return;
                                    }

                                    context
                                        .read<UserBloc>()
                                        .add(LoginUser(email, password, role));
                                  },
                                ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildTabView({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? appDefaultColor : Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
