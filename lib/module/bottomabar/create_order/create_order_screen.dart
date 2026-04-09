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
import '../../../utilities/image_utility.dart';
import '../../../utilities/style_utility.dart';
import '../../../utilities/text_size_utility.dart';
import '../../../widgets/select_google_location_screen.dart';
import 'create_order_vm.dart';
import 'model/create_order_request.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  TextEditingController pickupCityController = TextEditingController();
  TextEditingController dropCityController = TextEditingController();

  TextEditingController pickupAddressController = TextEditingController();
  TextEditingController dropAddressController = TextEditingController();

  TextEditingController cargoWeightController = TextEditingController();
  TextEditingController cargoDescriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController minBudgetController = TextEditingController();
  TextEditingController maxBudgetController = TextEditingController();
  TextEditingController specialRequirementsController = TextEditingController();

  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  String? countryCode;

  int gender = 1;

  CreateOrderVm? createOrderVm;

  final _formKey = GlobalKey<FormState>();

  String? selectedTruck;
  String? selectedTimeDrop;

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
                    title: "Pickup Address",
                    controller: pickupAddressController,
                    hintText: "Enter pickup address",
                    validator: Validators(context).requireField,
                    readOnly: true,
                    onTap: () async {

                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AutocompleteLocationScreen(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                         String locationName = result.description;
                        var  lat = double.tryParse(result.lat ?? "");
                         var lng = double.tryParse(result.lng ?? "");
                         pickupAddressController.text = locationName ?? "";

                        });
                      }


                    },
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    // preffixImage: ImageUtility.userIcon,
                    title: "Drop Off Address",
                    controller: dropAddressController,
                    hintText: "Enter drop off address",
                    validator: Validators(context).requireField,
                    readOnly: true,
                    onTap: () async {

                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AutocompleteLocationScreen(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          String locationName = result.description;
                          var  lat = double.tryParse(result.lat ?? "");
                          var lng = double.tryParse(result.lng ?? "");
                          dropAddressController.text = locationName ?? "";

                        });
                      }


                    },
                  ),
                  // SizedBox(height: 16.h),
                  //
                  // SimpleTextField(
                  //   // preffixImage: ImageUtility.userIcon,
                  //   title: "Pickup City",
                  //   controller: pickupCityController,
                  //   hintText: "Enter pickup city",
                  //   validator: Validators(context).requireField,
                  // ),
                  //
                  // SizedBox(height: 16.h),
                  //
                  // SimpleTextField(
                  //   // preffixImage: ImageUtility.userIcon,
                  //   title: "Drop Off City",
                  //   controller: dropCityController,
                  //   hintText: "Enter drop off city",
                  //   validator: Validators(context).requireField,
                  // ),
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
                    title: "Material Type",
                    controller: cargoDescriptionController,
                    textInputType: TextInputType.text,
                    hintText: "Enter material type",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),

                  // SimpleTextField(
                  //   //  preffixImage: ImageUtility.gstIcon,
                  //   title: "Preferred Vehicle Type",
                  //   controller: vehicleTypeController,
                  //   textInputType: TextInputType.text,
                  //   hintText: "Enter vehicle type",
                  //   validator: Validators(context).requireField,
                  // ),
                  TruckDropdown(
                    selectedTruck: selectedTruck,
                    title :"Select vehicle type",
                    truckTypes: [
                      "mini_truck",
                      "small_truck",
                      "medium_truck",
                      "large_truck",
                      "any",
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedTruck = value;
                      });
                    },
                  ),

                  // SizedBox(height: 16.h),
                  //
                  // SimpleTextField(
                  //   //  preffixImage: ImageUtility.gstIcon,
                  //   title: "Pickup Date",
                  //   readOnly: true,
                  //   controller: dateController,
                  //   textInputType: TextInputType.text,
                  //   hintText: "Enter pickup date",
                  //   onTap: () async {
                  //     final date = await showDatePicker(
                  //       context: context,
                  //       firstDate: DateTime.now(),
                  //       lastDate: DateTime.now().add(const Duration(days: 365)),
                  //       initialDate: DateTime.now(),
                  //     );
                  //     if (date != null) {
                  //       setState(() {
                  //         selectedDate = date;
                  //         dateController.text =
                  //             "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}";
                  //       });
                  //     }
                  //   },
                  //   validator: Validators(context).requireField,
                  // ),

                // SizedBox(height: 16.h),

                  // SimpleTextField(
                  //   //   preffixImage: ImageUtility.gstIcon,
                  //   //   isEnable: false,
                  //   readOnly: true,
                  //   title: "Pickup Time",
                  //   controller: timeController,
                  //   textInputType: TextInputType.text,
                  //   hintText: "Select pickup time",
                  //   validator: Validators(context).requireField,
                  //   onTap: () async {
                  //     final time = await showTimePicker(
                  //       context: context,
                  //       initialTime: TimeOfDay.now(),
                  //       builder: (context, child) {
                  //         return Theme(
                  //           data: Theme.of(context).copyWith(
                  //             useMaterial3: false, // ✅ IMPORTANT
                  //           ),
                  //
                  //           child: child!,
                  //         );
                  //       },
                  //     );
                  //
                  //     if (time != null) {
                  //       setState(() {
                  //         selectedTime = time;
                  //         timeController.text = selectedTime!.format(context);
                  //       });
                  //       //  setState(() => selectedTime = time);
                  //     }
                  //   },
                  // ),

                  // TruckDropdown(
                  //   selectedTruck: selectedTimeDrop,
                  //   title :"Select time",
                  //   hintText :"Select time",
                  //   truckTypes: [
                  //     "morning",
                  //     "afternoon",
                  //     "evening",
                  //     "flexible"],
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedTimeDrop = value;
                  //     });
                  //   },
                  // ),



                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //   preffixImage: ImageUtility.gstIcon,
                    title: "Budget",
                    controller: minBudgetController,
                    textInputType: TextInputType.number,
                    hintText: "Enter budget",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),






                  SizedBox(height: 77.h),
                  CustomButton(
                    buttonText: "Create Order",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        createOrderVm?.request = CreateOrderRequest(
                          pickupAddress: pickupAddressController.text.trim(),
                          dropoffAddress: dropAddressController.text.trim(),
                          pickupCity: pickupCityController.text.trim(),
                          dropoffCity: dropCityController.text.trim(),
                          cargoWeight: cargoWeightController.text.trim(),
                          cargoDescription: cargoDescriptionController.text,
                          preferredVehicleType: selectedTruck,
                          pickupDate: dateController.text.trim(),
                          pickupTimePreference: selectedTimeDrop,
                          budgetRangeMin: minBudgetController.text.trim(),
                          budgetRangeMax: maxBudgetController.text.trim(),
                          specialRequirements: specialRequirementsController.text.trim(),

                          pickupLat: 22.72,
                          pickupLng: 75.86,
                          dropoffLat: 22.96,
                          dropoffLng: 76.05,
                        );

                        CommonMethod.showLoadingDialog(context);
                        createOrderVm?.createRide(
                          onSuccess: (v) {
                            Navigator.pop(context);
                            AppRoute.bottomBarScreen(context);
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

class _LocationInputCard extends StatelessWidget {
  const _LocationInputCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorUtility.color8D98AF),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _dot(ColorUtility.colorEA580C),
                    Container(
                      width: 2,
                      height: 36.h,
                      color: Colors.grey.shade300,
                    ),
                    Image.asset(ImageUtility.unLoadingIconIcon, width: 18.w),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Loading Location?",
                        style: StyleUtility.inputTextStyle,
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 8.h),
                        child: Divider(color: ColorUtility.color6E6E6E),
                      ),
                      Text(
                        "Select Unloading Location?",
                        style: StyleUtility.inputTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}


class TruckDropdown extends StatefulWidget {
  final String? hintText;
  final String title;
  String? selectedTruck;
  final List<String> truckTypes;
  final Function(String?)? onChanged; // 👈 callback

  TruckDropdown({
    super.key,
    this.hintText,
    required this.title,
    this.selectedTruck,
    required this.truckTypes,
    this.onChanged,
  });

  @override
  State<TruckDropdown> createState() => _TruckDropdownState();
}

class _TruckDropdownState extends State<TruckDropdown> {
  // final List<String> truckTypes = [
  //   "mini_truck",
  //   "small_truck",
  //   "medium_truck",
  //   "large_truck",
  //   "any",
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,

      children: [
        Text(widget.title, style: StyleUtility.inputTextStyle),
        SizedBox(height: 9.h),

        DropdownButtonFormField<String>(
          value: widget.selectedTruck,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(
              left: 20.w,
              top: 16,
              bottom: 16,
              right: 5.w,
            ),
            filled: true,
            fillColor: Colors.white,
            hintStyle: StyleUtility.hintTextStyle,
            hintText: widget.hintText ?? "Select Truck Type",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            errorStyle: StyleUtility.errorTextStyle.copyWith(
              fontSize: TextSizeUtility.textSize13.sp,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),

            focusColor: Colors.white,
          ),
          items: widget.truckTypes
              .map(
                (truck) => DropdownMenuItem<String>(
                  value: truck,
                  child: Text(
                    truck.replaceAll("_", " ").toUpperCase(),
                    style: StyleUtility.inputTextStyle,
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            widget.onChanged?.call(value); // 👈 send value to parent
          },
        ),
      ],
    );
  }
}
