import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/features/profile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:clone_green_dot/features/profile/edit_profile/services/edit_profile_service.dart';
import 'package:clone_green_dot/features/profile/update_profile/bloc/update_profile_bloc.dart';
import 'package:clone_green_dot/features/splash/splash_screen.dart';
import 'package:clone_green_dot/features/auth/customer_registration/bloc/customer_registration_bloc.dart';
import 'package:clone_green_dot/features/auth/login/bloc/login_bloc.dart';
import 'package:clone_green_dot/features/otp/bloc/otp_bloc.dart';
import 'package:clone_green_dot/utils/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerRegistrationBloc>(
          create: (context) => CustomerRegistrationBloc(),
        ),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<OtpBloc>(create: (context) => OtpBloc()),
        BlocProvider<EditProfileBloc>(
          create: (context) =>
              EditProfileBloc(editProfile: EditProfileService()),
        ),
        BlocProvider<UpdateProfileBloc>(
          create: (context) => UpdateProfileBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Green Dot',
        home: SplashScreen(),
      ),
    );
  }
}
