import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/const/version_constants.dart';
import 'package:clone_green_dot/features/profile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:clone_green_dot/features/profile/edit_profile/bloc/edit_profile_event.dart';
import 'package:clone_green_dot/features/profile/edit_profile/bloc/edit_profile_state.dart';
import 'package:clone_green_dot/features/profile/update_profile/screen/update_profile_screen.dart';
import 'package:clone_green_dot/widgets/bottom_nav_bar.dart';
import 'package:clone_green_dot/utils/hive_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _countryCodeController = TextEditingController(text: '+91');
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() {
    final userId = HiveService.getUserId();
    if (userId != null && userId > 0) {
      context.read<EditProfileBloc>().add(
        FetchEditProfileEvent(userId: userId),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: User not logged in')),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _countryCodeController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildProfileInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey[400]!, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF757373), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getGenderLabel(int? genderCode) {
    switch (genderCode) {
      case 2:
        return 'Male';
      case 3:
        return 'Female';
      case 4:
        return 'Other';
      case 5:
        return 'Prefer not to say';
      default:
        return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_left, color: Colors.black),
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
        ),
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error:${state.message}')));
          }
        },
        child: SafeArea(
          child: BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, state) {
              if (state is EditProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.green),
                );
              }
              if (state is EditProfileLoaded && state.users.isNotEmpty) {
                final user = state.users[0];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildProfileInfoCard(
                        icon: CupertinoIcons.person,
                        label: 'First Name',
                        value: user.firstName ?? 'N/A',
                      ),
                      const SizedBox(height: 16),
                      _buildProfileInfoCard(
                        icon: CupertinoIcons.person,
                        label: 'Last Name',
                        value: user.lastName ?? 'N/A',
                      ),
                      const SizedBox(height: 16),
                      _buildProfileInfoCard(
                        icon: CupertinoIcons.globe,
                        label: 'Country Code',
                        value: user.countryCode ?? 'N/A',
                      ),
                      const SizedBox(height: 16),
                      _buildProfileInfoCard(
                        icon: CupertinoIcons.phone,
                        label: 'Mobile Number',
                        value: user.phone ?? 'N/A',
                      ),
                      const SizedBox(height: 16),
                      _buildProfileInfoCard(
                        icon: CupertinoIcons.mail,
                        label: 'Email',
                        value: user.email ?? 'N/A',
                      ),
                      const SizedBox(height: 16),
                      _buildProfileInfoCard(
                        icon: CupertinoIcons.person_2,
                        label: 'Gender',
                        value: _getGenderLabel(user.gender),
                      ),
                      const SizedBox(height: 16),
                      _buildProfileInfoCard(
                        icon: CupertinoIcons.lock,
                        label: 'Password',
                        value: user.password != null ? '••••••••' : 'N/A',
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              }
              return const Center(child: Text('No user data available'));
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'App Version - ${Version.version}',
              style: const TextStyle(
                color: Color.fromARGB(255, 95, 91, 91),
                fontWeight: FontWeight.w500,
              ),
            ),
            Image.asset(
              'assets/logo.png',
              width: 100,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
