import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'model/VahicleCategoryModel.dart';
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
  TextEditingController cargoMaterialController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController specialRequirementsController = TextEditingController();

  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  String? countryCode;

  int gender = 1;

  double? pickupLat;
  double? pickupLng;
  double? pickupId;

  double? dropLat;
  double? dropLng;
  double? dropId;

  CreateOrderVm? createOrderVm;

  final _formKey = GlobalKey<FormState>();

  Vehiclecategory? selectedTruck;
  String? selectedTimeDrop;

  @override
  void initState() {
    super.initState();
    createOrderVm = Provider.of<CreateOrderVm>(context, listen: false);

    createOrderVm?.fetchVehicleCategory(onSuccess: (v) {}, onFailure: (v) {});
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
                          builder: (context) =>
                              const AutocompleteLocationScreen(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          String locationName = result.description;
                          pickupId = result.id;
                          pickupLat = double.tryParse(result.lat ?? "");
                          pickupLng = double.tryParse(result.lng ?? "");
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
                          builder: (context) =>
                              const AutocompleteLocationScreen(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          String locationName = result.description;

                          dropAddressController.text = locationName ?? "";

                          dropId = result.id;
                          dropLat = double.tryParse(result.lat ?? "");
                          dropLng = double.tryParse(result.lng ?? "");
                        });
                      }
                    },
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //  preffixImage: ImageUtility.emailIcon,
                    textInputType: TextInputType.number,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    title: "Cargo Weight in Tons",
                    controller: cargoWeightController,
                    hintText: "Cargo weight",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),

                  SimpleTextField(
                    //   preffixImage: ImageUtility.gstIcon,
                    title: "Material Type",
                    controller: cargoMaterialController,
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

                  // TruckDropdown(
                  //   selectedTruck: selectedTruck,
                  //   title :"Select vehicle type",
                  //   truckTypes: [
                  //     "mini_truck",
                  //     "small_truck",
                  //     "medium_truck",
                  //     "large_truck",
                  //     "any",
                  //   ],
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedTruck = value;
                  //     });
                  //   },
                  // ),
                  Consumer<CreateOrderVm>(
                    builder: (context, provider, child) {
                      return TruckDropdown(
                        selectedTruck: selectedTruck,
                        title: "Select vehicle type",
                        truckTypes: createOrderVm!.vehicleCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedTruck = value;
                          });
                        },
                      );
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
                    controller: budgetController,
                    textInputType: TextInputType.number,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    hintText: "Enter budget",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 32.h),

                  CustomButton(
                    buttonText: "Create Order",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        createOrderVm?.request = CreateOrderRequest(
                          pickupAddress: pickupAddressController.text.trim(),
                          dropoffAddress: dropAddressController.text.trim(),
                          pickupPlaceName: pickupAddressController.text.trim(),
                          dropoffPlaceName: dropAddressController.text.trim(),
                          cargoWeight: int.parse(cargoWeightController.text.trim()),
                          cargoDescription: "d",

                          pickupLat: pickupLat,
                          pickupLng: pickupLng,
                          dropoffLat: dropLat,
                          dropoffLng: dropLng,

                          pickupPlaceId: "${pickupId ?? 0}",
                          dropoffPlaceId: "${dropId ?? 0}",
                          cargoMaterial: cargoMaterialController.text,
                          vehicleCategoryId: selectedTruck?.id,
                          budget:int.parse(budgetController.text.trim())
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

//
// class TruckDropdown extends StatefulWidget {
//   final String? hintText;
//   final String title;
//   String? selectedTruck;
//   final List<String> truckTypes;
//   final Function(String?)? onChanged; // 👈 callback
//
//   TruckDropdown({
//     super.key,
//     this.hintText,
//     required this.title,
//     this.selectedTruck,
//     required this.truckTypes,
//     this.onChanged,
//   });
//
//   @override
//   State<TruckDropdown> createState() => _TruckDropdownState();
// }
//
// class _TruckDropdownState extends State<TruckDropdown> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: .start,
//
//       children: [
//         Text(widget.title, style: StyleUtility.inputTextStyle),
//         SizedBox(height: 9.h),
//
//         DropdownButtonFormField<String>(
//           value: widget.selectedTruck,
//           isExpanded: true,
//           icon: const Icon(Icons.keyboard_arrow_down),
//           decoration: InputDecoration(
//             isDense: true,
//             contentPadding: EdgeInsets.only(
//               left: 20.w,
//               top: 16,
//               bottom: 16,
//               right: 5.w,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             hintStyle: StyleUtility.hintTextStyle,
//             hintText: widget.hintText ?? "Select Truck Type",
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: ColorUtility.textFieldBorderColor,
//               ),
//             ),
//             errorStyle: StyleUtility.errorTextStyle.copyWith(
//               fontSize: TextSizeUtility.textSize13.sp,
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: ColorUtility.textFieldBorderColor,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: ColorUtility.textFieldBorderColor,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: ColorUtility.textFieldBorderColor,
//               ),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: ColorUtility.textFieldBorderColor,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.r),
//               borderSide: const BorderSide(
//                 color: ColorUtility.textFieldBorderColor,
//               ),
//             ),
//
//             focusColor: Colors.white,
//           ),
//           items: widget.truckTypes
//               .map(
//                 (truck) => DropdownMenuItem<String>(
//                   value: truck,
//                   child: Text(
//                     truck.replaceAll("_", " ").toUpperCase(),
//                     style: StyleUtility.inputTextStyle,
//                   ),
//                 ),
//               )
//               .toList(),
//           onChanged: (value) {
//             widget.onChanged?.call(value); // 👈 send value to parent
//           },
//         ),
//       ],
//     );
//   }
// }

class TruckDropdown extends StatelessWidget {
  final String? hintText;
  final String title;
  final Vehiclecategory? selectedTruck;
  final List<Vehiclecategory> truckTypes;
  final Function(Vehiclecategory?)? onChanged;

  const TruckDropdown({
    super.key,
    this.hintText,
    required this.title,
    this.selectedTruck,
    required this.truckTypes,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: StyleUtility.inputTextStyle),
        SizedBox(height: 9.h),

        DropdownButtonFormField<Vehiclecategory>(
          value: selectedTruck,
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
            hintText: hintText ?? "Select Truck Type",
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


          items: truckTypes.map((truck) {
            return DropdownMenuItem<Vehiclecategory>(
              value: truck,
              child: Text(
                (truck.name ?? "").toUpperCase(),
                style: StyleUtility.inputTextStyle,
              ),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ],
    );
  }
}
