import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/features/booking_folder/booking/bloc/booking_bloc.dart';
import 'package:clone_green_dot/features/booking_folder/booking/bloc/booking_state.dart';
import 'package:clone_green_dot/features/booking_folder/booking/bloc/booking_event.dart';
import 'package:clone_green_dot/features/booking_folder/booking/model/booking_model.dart';
import 'package:clone_green_dot/features/home/bloc/service_bloc.dart';
import 'package:clone_green_dot/features/home/bloc/service_event.dart';
import 'package:clone_green_dot/features/home/bloc/service_state.dart';
import 'package:clone_green_dot/features/home/model/service_model.dart';
import 'package:clone_green_dot/features/home/screen/home_screen.dart';
import 'package:clone_green_dot/features/home/service/service_api.dart';
// import 'package:clone_green_dot/features/booking_folder/id_pass/employee_schedule/bloc/employee_schedule_bloc.dart';
// import 'package:clone_green_dot/features/booking_folder/id_pass/employee_schedule/bloc/employee_schedule_event.dart';
// import 'package:clone_green_dot/features/booking_folder/id_pass/employee_schedule/bloc/employee_schedule_state.dart';
// import 'package:clone_green_dot/features/booking_folder/id_pass/employee_schedule/model/employee_schedule_model.dart';
// import 'package:clone_green_dot/features/booking_folder/id_pass/employee_schedule/service/employee_schedule_service.dart';
import 'package:clone_green_dot/utils/hive_service.dart';
import 'package:clone_green_dot/widgets/bottom_nav_bar.dart';

class BookingScreen extends StatefulWidget {
  final int? assignedTherapistId;

  const BookingScreen({super.key, this.assignedTherapistId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TimeOfDay? _endTime;
  ServiceData? _selectedService;
  // EmployeeSchedule? _selectedTherapist;
  List<ServiceData> _services = [];
  // List<EmployeeSchedule> _therapists = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // If therapist is pre-selected, find it in the list once loaded
  //   if (widget.assignedTherapistId != null) {
  //     // Will be set when therapists are loaded
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookingBloc()),
        BlocProvider(
          create: (context) =>
              ServiceBloc(serviceApi: ServiceApi())..add(FetchServicesEvent()),
        ),
        // BlocProvider(
        //   create: (context) => EmployeeScheduleBloc(
        //     employeeScheduleService: EmployeeScheduleService(),
        //   )..add(FetchEmployeeScheduleEvent()),
        // ),
      ],
      child: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            });
          } else if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, bookingState) {
          return BlocListener<ServiceBloc, ServiceState>(
            listener: (context, serviceState) {
              if (serviceState is ServiceLoaded) {
                setState(() {
                  _services = serviceState.services;
                });
              }
            },
            // return MultiBlocListener(
            //   listeners: [
            //     BlocListener<ServiceBloc, ServiceState>(
            //       listener: (context, serviceState) {
            //         if (serviceState is ServiceLoaded) {
            //           setState(() {
            //             _services = serviceState.services;
            //           });
            //         }
            //       },
            //     ),
            //     BlocListener<EmployeeScheduleBloc, EmployeeScheduleState>(
            //       listener: (context, employeeState) {
            //         if (employeeState is EmployeeScheduleLoaded) {
            //           setState(() {
            //             _therapists = employeeState.employees;
            //             // If therapist was pre-selected, find and set it
            //             if (widget.assignedTherapistId != null) {
            //               _selectedTherapist = _therapists.firstWhere(
            //                 (t) => t.id == widget.assignedTherapistId,
            //                 orElse: () => _therapists.first,
            //               );
            //             }
            //           });
            //         }
            //       },
            //     ),
            //   ],
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                    );
                  },
                ),
                title: const Row(
                  children: [
                    SizedBox(width: 60),
                    Text(
                      'Book Appointment',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                titleSpacing: 0,
              ),
              body: BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, serviceState) {
                  final isLoadingServices = serviceState is ServiceLoading;
                  // final isLoadingEmployees = context.watch<EmployeeScheduleBloc>().state is EmployeeScheduleLoading;

                  if (isLoadingServices) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }

                  if (serviceState is ServiceError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error loading data',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ServiceBloc>().add(
                                FetchServicesEvent(),
                              );
                              // context
                              //     .read<EmployeeScheduleBloc>()
                              //     .add(FetchEmployeeScheduleEvent());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  return SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            InkWell(
                              onTap: () => _pickDate(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.calendar,
                                      color: Color(0xFF757373),
                                    ),
                                    Text(
                                      _selectedDate == null
                                          ? 'Select booking date'
                                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            InkWell(
                              onTap: () => _pickTime(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.timer,
                                      color: Color(0xFF757373),
                                    ),
                                    Text(
                                      _selectedTime == null
                                          ? 'Select booking time'
                                          : _selectedTime!.format(context),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            InkWell(
                              onTap: () => _pickEndTime(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.time,
                                      color: Color(0xFF757373),
                                    ),
                                    Text(
                                      _endTime == null
                                          ? 'Select end time'
                                          : _endTime!.format(context),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Container(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 16),
                            //   decoration: BoxDecoration(
                            //     border:
                            //         Border.all(color: Colors.green, width: 2),
                            //     borderRadius: BorderRadius.circular(30),
                            //   ),
                            //   child: DropdownButtonHideUnderline(
                            //     child: DropdownButton<EmployeeSchedule>(
                            //       value: _selectedTherapist,
                            //       hint: const Text('Select Therapist'),
                            //       icon: const Icon(CupertinoIcons.chevron_down),
                            //       isExpanded: true,
                            //       items: _therapists.map((therapist) {
                            //         return DropdownMenuItem<EmployeeSchedule>(
                            //           value: therapist,
                            //           child: Text(therapist.name),
                            //         );
                            //       }).toList(),
                            //       onChanged: (value) {
                            //         setState(() {
                            //           _selectedTherapist = value;
                            //         });
                            //       },
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<ServiceData>(
                                  value: _selectedService,
                                  hint: const Text('Select Service'),
                                  icon: const Icon(CupertinoIcons.chevron_down),
                                  isExpanded: true,
                                  items: _services.map((service) {
                                    return DropdownMenuItem<ServiceData>(
                                      value: service,
                                      child: Text(service.serviceName),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedService = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),

                            Builder(
                              builder: (btnContext) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: bookingState is BookingLoading
                                        ? null
                                        : () => _confirmSelection(btnContext),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: bookingState is BookingLoading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text(
                                            'Confirm',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _pickEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  void _confirmSelection(BuildContext context) {
    if (_selectedDate == null ||
        _selectedTime == null ||
        _endTime == null ||
        _selectedService == null) {
      // || _selectedTherapist == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int? patientId = HiveService.getRegistrationId();

    if (patientId == null) {
      patientId = HiveService.getUserId();
    }

    if (patientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Patient ID not found. Please login again.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final formattedDate =
        '${_selectedDate!.year}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.day.toString().padLeft(2, '0')}';

    final formattedStartTime =
        '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year} ${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}:00';
    final formattedEndTime =
        '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year} ${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}:00';

    final therapistId = widget.assignedTherapistId ?? 1;

    final service = Service(
      serviceId: _selectedService!.id,
      name: _selectedService!.serviceName,
      price: _selectedService!.price,
      quantity: 1,
      assignedEmployeeId: therapistId,
      bookingTime: formattedStartTime,
    );

    context.read<BookingBloc>().add(
      SubmitBookingEvent(
        patientId: patientId,
        bookingDate: formattedDate,
        bookingTime: formattedStartTime,
        bookingEndTime: formattedEndTime,
        assignedTherapistId: therapistId,
        services: [service],
      ),
    );
  }
}
