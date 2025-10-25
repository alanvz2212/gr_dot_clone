import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clone_green_dot/widgets/bottom_nav_bar.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
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
          'Booking Details',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        titleSpacing: 0,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.edit, color: Colors.black),
        //     onPressed: () {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
        //       );
        //     },
        //   ),
        // ],
      ),
    );
  }
}
