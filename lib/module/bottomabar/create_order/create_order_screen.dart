import 'package:book_your_truck/logger/app_logger.dart';
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
import '../../../utilities/style_utility.dart';
import '../../../utilities/text_size_utility.dart';
import '../../../widgets/select_google_location_screen.dart';
import 'create_order_vm.dart';
import 'model/create_order_request.dart';
import 'model/vehicle_category_model.dart';

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

  late CreateOrderVm createOrderVm;

  final _formKey = GlobalKey<FormState>();

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
                    //   preffixImage: ImageUtility.gstIcon,
                    title: "Material Type",
                    controller: cargoMaterialController,
                    textInputType: TextInputType.text,
                    hintText: "Enter material type",
                    validator: Validators(context).requireField,
                  ),

                  SizedBox(height: 16.h),

                  Consumer<CreateOrderVm>(
                    builder: (context, vm, child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// 🔹 CATEGORY DROPDOWN
                          CommonDropdown<Data>(
                            hint: "Select Vehicle Category",
                            title: "Vehicle Category",
                            value: vm.selectedCategory,
                            items: vm.categories,
                            itemLabel: (item) => item.categoryName ?? "",
                            onChanged: vm.categories.isEmpty
                                ? null
                                : (value) {
                                    if (value != null) {
                                      vm.selectCategory(value);
                                    }
                                  },
                          ),

                          SizedBox(height: 16),

                          CommonDropdown<SubCategories>(
                            hint: "Select Sub Category",
                            title: "Sub Category",

                            value: vm.selectedSubCategory,
                            items: vm.selectedCategory?.subCategories ?? [],
                            itemLabel: (item) => item.type ?? "",
                            onChanged: vm.selectedCategory == null
                                ? null
                                : (value) {
                                    if (value != null) {
                                      vm.selectSubCategory(value);
                                    }
                                  },
                          ),

                          SizedBox(height: 16.h),

                          CommonDropdown<Variants>(
                            hint: "Select Variant",
                            title: "Variant",

                            value: vm.selectedVariant,
                            items: vm.selectedSubCategory?.variants ?? [],
                            itemLabel: (item) =>
                                "${item.weight ?? 0} Ton - ${item.length ?? 0} Feet",
                            onChanged: vm.selectedSubCategory == null
                                ? null
                                : (value) {
                                    if (value != null) {
                                      vm.selectVariant(value);
                                    }
                                  },
                          ),

                          SizedBox(height: 30),

                          // /// ✅ FINAL SELECTED DATA
                          // if (vm.selectedVariant != null)
                          //   Text(
                          //     "Selected:\n"
                          //     "${vm.selectedCategory?.categoryName} → "
                          //     "${vm.selectedSubCategory?.type} → "
                          //     "${vm.selectedVariant?.weight} Ton, "
                          //     "${vm.selectedVariant?.length} m",
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //   ),
                        ],
                      );
                    },
                  ),



                  SimpleTextField(
                    //   preffixImage: ImageUtility.gstIcon,
                    title: "Budget",
                    controller: budgetController,
                    textInputType: TextInputType.number,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
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
                          cargoDescription: "d",
                          pickupLat: pickupLat,
                          pickupLng: pickupLng,
                          dropoffLat: dropLat,
                          dropoffLng: dropLng,

                          pickupPlaceId: "${pickupId ?? 0}",
                          dropoffPlaceId: "${dropId ?? 0}",
                          cargoMaterial: cargoMaterialController.text,
                            vehicleCategoryId: createOrderVm?.selectedVariant?.id ?? 0,
                          budget: int.parse(budgetController.text.trim()),
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

class CommonDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T?)? onChanged;
  final String title;

  const CommonDropdown({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: StyleUtility.inputTextStyle),

        SizedBox(height: 3.5.h),
        DropdownButtonFormField<T>(
          hint: Text(hint),
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item)),
            );
          }).toList(),
          onChanged: onChanged,

          /// 🔥 Common Decoration (ek hi jagah manage hoga)
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              // borderSide: BorderSide.none,
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
        ),
      ],
    );
  }
}
