import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_green_dot/const/version_constants.dart';
import 'package:clone_green_dot/features/booking_folder/booking/bloc/booking_bloc.dart';
import 'package:clone_green_dot/features/booking_folder/booking/bloc/booking_state.dart';
import 'package:clone_green_dot/features/booking_folder/booking/bloc/booking_event.dart';
import 'package:clone_green_dot/features/booking_folder/booking/model/booking_model.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/model/assigned_therapist_list_model.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/bloc/assigned_therapist_list_bloc.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/bloc/assigned_therapist_list_event.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/bloc/assigned_therapist_list_state.dart';
import 'package:clone_green_dot/features/booking_folder/id_pass/assigned_therapist_list/services/assigned_therapist_list_service.dart';
import 'package:clone_green_dot/features/home/bloc/service_bloc.dart';
import 'package:clone_green_dot/features/home/bloc/service_event.dart';
import 'package:clone_green_dot/features/home/bloc/service_state.dart';
import 'package:clone_green_dot/features/home/model/service_model.dart';
import 'package:clone_green_dot/features/home/screen/home_screen.dart';
import 'package:clone_green_dot/features/home/service/service_api.dart';
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
  List<ServiceData> _selectedServices = [];
  TherapistData? _selectedTherapist;

  List<ServiceData> _services = [];
  List<TherapistData> _therapist = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookingBloc()),
        BlocProvider(
          create: (context) =>
              ServiceBloc(serviceApi: ServiceApi())..add(FetchServicesEvent()),
        ),
        BlocProvider(
          create: (context) => AssignedTherapistListBloc(
            assignedTherapistListService: AssignedTherapistListService(),
          )..add(FetchAssignedTherapistListEvent()),
        ),
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
                setState(() {
                  _selectedDate = null;
                  _selectedTime = null;
                  _endTime = null;
                  _selectedServices = [];
                  _selectedTherapist = null;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Replace the existing selected services display section with this:
                                // Replace the existing selected services display section with this:
                                // Replace the existing selected services display section with this:
                                if (_selectedServices.isNotEmpty) ...[
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Selected Services:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ..._selectedServices
                                            .map(
                                              (service) => Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8,
                                                ),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                    border: Border.all(
                                                      color:
                                                          Colors.green.shade200,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              service
                                                                  .serviceName,
                                                              style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .time,
                                                                  size: 14,
                                                                  color: Colors
                                                                      .grey[600],
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  '${service.serviceDuration ?? 0} min',
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey[600],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 12,
                                                                ),
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .money_dollar_circle,
                                                                  size: 14,
                                                                  color: Colors
                                                                      .grey[600],
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  '₹${service.price.toStringAsFixed(2)}',
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey[600],
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 20,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            _selectedServices
                                                                .remove(
                                                                  service,
                                                                );
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        const Divider(height: 20),
                                        // Total summary
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Total:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${_selectedServices.fold(0, (sum, service) => sum + (service.serviceDuration ?? 0))} min',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '₹${_selectedServices.fold(0.0, (sum, service) => sum + service.price).toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
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
                                      value: null,
                                      hint: Text(
                                        _selectedServices.isEmpty
                                            ? 'Select Services'
                                            : 'Add More Services',
                                      ),
                                      icon: const Icon(
                                        CupertinoIcons.chevron_down,
                                      ),
                                      isExpanded: true,
                                      items: _buildGroupedServiceItems(),
                                      onChanged: (value) {
                                        if (value != null &&
                                            !_selectedServices.contains(
                                              value,
                                            )) {
                                          setState(() {
                                            _selectedServices.add(value);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<
                              AssignedTherapistListBloc,
                              AssignedTherapistListState
                            >(
                              builder: (context, therapistState) {
                                if (therapistState
                                    is AssignedTherapistListError) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          color: Colors.red.shade50,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Error: ${therapistState.message}',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.refresh,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<
                                                      AssignedTherapistListBloc
                                                    >()
                                                    .add(
                                                      FetchAssignedTherapistListEvent(),
                                                    );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                }

                                return Container(
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
                                    child: DropdownButton<TherapistData>(
                                      value: _selectedTherapist,
                                      hint: const Text('Assigned Therapist'),
                                      icon: const Icon(
                                        CupertinoIcons.chevron_down,
                                      ),
                                      isExpanded: true,
                                      items: _buildAssignedTherapistList(
                                        therapistState,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedTherapist = value;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
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
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  top: 8,
                ),
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
            ),
          );
        },
      ),
    );
  }

  List<DropdownMenuItem<ServiceData>> _buildGroupedServiceItems() {
    Map<String, List<ServiceData>> groupedServices = {};

    for (var service in _services) {
      if (!groupedServices.containsKey(service.serviceType)) {
        groupedServices[service.serviceType] = [];
      }
      groupedServices[service.serviceType]!.add(service);
    }

    List<DropdownMenuItem<ServiceData>> items = [];

    groupedServices.forEach((serviceType, services) {
      items.add(
        DropdownMenuItem<ServiceData>(
          enabled: false,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              serviceType,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.green,
              ),
            ),
          ),
        ),
      );

      for (var service in services) {
        items.add(
          DropdownMenuItem<ServiceData>(
            value: service,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                service.serviceName,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        );
      }
    });

    return items;
  }

  List<DropdownMenuItem<TherapistData>> _buildAssignedTherapistList(
    AssignedTherapistListState therapistState,
  ) {
    List<DropdownMenuItem<TherapistData>> items = [];

    if (therapistState is AssignedTherapistListLoaded) {
      _therapist = therapistState.service;

      if (widget.assignedTherapistId != null && _selectedTherapist == null) {
        _selectedTherapist = _therapist.firstWhere(
          (t) => t.id == widget.assignedTherapistId,
          orElse: () => _therapist.isNotEmpty
              ? _therapist.first
              : TherapistData(id: 0, employeeName: ''),
        );
      }

      items.add(
        DropdownMenuItem<TherapistData>(
          enabled: false,
          child: Text(
            'Available Therapists (${_therapist.length})',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.green,
            ),
          ),
        ),
      );

      items.addAll(
        _therapist.map((therapist) {
          return DropdownMenuItem<TherapistData>(
            value: therapist,
            child: Text(therapist.employeeName),
          );
        }).toList(),
      );
    } else if (therapistState is AssignedTherapistListLoading) {
      items.add(
        const DropdownMenuItem<TherapistData>(
          enabled: false,
          child: Text('Loading therapists...'),
        ),
      );
    } else if (therapistState is AssignedTherapistListError) {
      items.add(
        DropdownMenuItem<TherapistData>(
          enabled: false,
          child: Text('Error: ${therapistState.message}'),
        ),
      );
    } else {
      items.add(
        const DropdownMenuItem<TherapistData>(
          enabled: false,
          child: Text('Select a therapist'),
        ),
      );
    }

    return items;
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
        final startDateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          picked.hour,
          picked.minute,
        );
        final endDateTime = startDateTime.add(const Duration(hours: 1));
        _endTime = TimeOfDay.fromDateTime(endDateTime);
      });
    }
  }

  String _getEndTime() {
    if (_selectedTime == null) return '';

    final now = DateTime.now();
    final startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final endDateTime = startDateTime.add(const Duration(hours: 1));
    final endTime = TimeOfDay.fromDateTime(endDateTime);

    return endTime.format(context);
  }

  void _confirmSelection(BuildContext context) {
    if (_selectedDate == null ||
        _selectedTime == null ||
        _selectedServices.isEmpty ||
        _selectedTherapist == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
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

    final hour = _selectedTime!.hour.toString().padLeft(2, '0');
    final minute = _selectedTime!.minute.toString().padLeft(2, '0');
    final day = _selectedDate!.day.toString().padLeft(2, '0');
    final month = _selectedDate!.month.toString().padLeft(2, '0');
    final year = _selectedDate!.year;

    final formattedStartTime = '$day/$month/$year $hour:$minute:00';

    final endDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    ).add(const Duration(hours: 1));

    final endHour = endDateTime.hour.toString().padLeft(2, '0');
    final endMinute = endDateTime.minute.toString().padLeft(2, '0');
    final endDay = endDateTime.day.toString().padLeft(2, '0');
    final endMonth = endDateTime.month.toString().padLeft(2, '0');
    final endYear = endDateTime.year;

    final formattedEndTime =
        '$endDay/$endMonth/$endYear $endHour:$endMinute:00';

    final therapistId = _selectedTherapist!.id;

    final hour12 = _selectedTime!.hour > 12
        ? _selectedTime!.hour - 12
        : (_selectedTime!.hour == 0 ? 12 : _selectedTime!.hour);
    final amPm = _selectedTime!.hour >= 12 ? 'PM' : 'AM';
    final serviceBookingTime =
        '${hour12.toString().padLeft(2, '0')}.${_selectedTime!.minute.toString().padLeft(2, '0')} $amPm';

    final services = _selectedServices
        .map(
          (selectedService) => Service(
            serviceId: selectedService.id,
            name: selectedService.serviceName,
            price: selectedService.price,
            quantity: 1,
            assignedEmployeeId: therapistId,
            bookingTime: serviceBookingTime,
          ),
        )
        .toList();
    print('Submitting booking with therapist ID: $therapistId');
    print('Selected therapist: ${_selectedTherapist!.employeeName}');
    print('Booking Date: $formattedDate');
    print('Booking Time: $formattedStartTime');
    print('Booking End Time: $formattedEndTime');
    print('Service Booking Time: $serviceBookingTime');

    context.read<BookingBloc>().add(
      SubmitBookingEvent(
        patientId: patientId,
        bookingDate: formattedDate,
        bookingTime: formattedStartTime,
        bookingEndTime: formattedEndTime,
        assignedTherapistId: therapistId,
        services: services,
      ),
    );
  }
}
