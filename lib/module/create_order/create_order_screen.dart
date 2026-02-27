import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utilities/app_notifier.dart';
import '../../../../utilities/color_utility.dart';
import '../../../../utilities/common.dart';
import '../../../../utilities/validation.dart';
import '../../../../widgets/buttons/custom_button.dart';
import '../../../../widgets/common_app_bar.dart';
import '../../../../widgets/textField/simple_text_field.dart';
import 'create_order_vm.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  TextEditingController pickupCityController = TextEditingController();
  TextEditingController dropCityController = TextEditingController();
  TextEditingController cargoWeightController = TextEditingController();
  TextEditingController cargoDescriptionController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController minBudgetController = TextEditingController();
  TextEditingController maxBudgetController = TextEditingController();

  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  String? countryCode;

  int gender = 1;

  CreateOrderVm? createOrderVm;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    createOrderVm = Provider.of<CreateOrderVm>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorF5F6FA,

      appBar: commonAppBar(title: "Create Order"),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.h),

                  SimpleTextField(
                    // preffixImage: ImageUtility.userIcon,
                    title: "Pickup City",
                    controller: pickupCityController,
                    hintText: "Enter pickup city",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    // preffixImage: ImageUtility.userIcon,
                    title: "Drop Off City",
                    controller: dropCityController,
                    hintText: "Enter drop off city",
                    validator: Validators(context).requireField,
                  ),
                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //  preffixImage: ImageUtility.emailIcon,
                    title: "Cargo Weight",
                    controller: cargoWeightController,
                    hintText: "Cargo weight",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //   preffixImage: ImageUtility.gstIcon,
                    title: "Cargo Description",
                    controller: cargoDescriptionController,
                    textInputType: TextInputType.text,
                    hintText: "Enter cargo description",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //  preffixImage: ImageUtility.gstIcon,
                    title: "Preferred Vehicle Type",
                    controller: vehicleTypeController,
                    textInputType: TextInputType.text,
                    hintText: "Enter vehicle type",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //  preffixImage: ImageUtility.gstIcon,
                    title: "Pickup Date",
                    readOnly: true,
                    controller: dateController,
                    textInputType: TextInputType.text,
                    hintText: "Enter pickup date",
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          selectedDate = date;
                          dateController.text =
                              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
                        });
                      }
                    },
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //   preffixImage: ImageUtility.gstIcon,
                    //   isEnable: false,
                    readOnly: true,
                    title: "Pickup Time",
                    controller: timeController,
                    textInputType: TextInputType.text,
                    hintText: "Select pickup time",
                    validator: Validators(context).requireField,
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              useMaterial3: false, // ✅ IMPORTANT
                            ),

                            child: child!,
                          );
                        },
                      );

                      if (time != null) {
                        setState(() {
                          selectedTime = time;
                          timeController.text = selectedTime!.format(context);
                        });
                        //  setState(() => selectedTime = time);
                      }
                    },
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //   preffixImage: ImageUtility.gstIcon,
                    title: "Budget Range Minimum",
                    controller: minBudgetController,
                    textInputType: TextInputType.number,
                    hintText: "Enter minimum budget range",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //  preffixImage: ImageUtility.gstIcon,
                    title: "Budget Range Maximum",
                    controller: maxBudgetController,
                    textInputType: TextInputType.number,
                    hintText: "Enter maximum budget range",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 77.h),
                  CustomButton(
                    buttonText: "Sign up",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // createOrderVm?.request = CreateOrderRequest(
                        //   fName: fNameController.text.trim(),
                        //   lName: lNameController.text.trim(),
                        //   email: emailController.text.trim(),
                        //   phone: mobileController.text,
                        //   gst_number: gstController.text.trim(),
                        //   // gender: addressController.text.trim(),
                        //   gender: gender == 1 ? "male" : "female",
                        // );

                        CommonMethod.showLoadingDialog(context);
                        createOrderVm?.signup(
                          onSuccess: (v) {
                            Navigator.pop(context);
                            AppRoute.loginScreen(context);
                            AppNotifier.showSuccessSnackBar(message: v);
                          },
                          onFailure: (v) {
                            Navigator.pop(context);
                            AppNotifier.showErrorSnackBar(message: v);
                          },
                          request: createOrderVm!.request,
                        );
                      }
                    },
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
