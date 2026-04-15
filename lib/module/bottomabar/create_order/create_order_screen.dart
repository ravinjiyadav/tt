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
  TextEditingController truckPreferenceController = TextEditingController();

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

    createOrderVm.fetchVehicleCategory(onSuccess: (v) {}, onFailure: (v) {});
  }

  @override
  void dispose() {
    pickupCityController.dispose();
    dropCityController.dispose();
    pickupAddressController.dispose();
    dropAddressController.dispose();
    cargoMaterialController.dispose();
    dateController.dispose();
    timeController.dispose();
    budgetController.dispose();
    specialRequirementsController.dispose();
    truckPreferenceController.dispose();
    super.dispose();
  }

  Future<void> _openTruckPreferenceSheet(CreateOrderVm vm) async {
    FocusScope.of(context).unfocus();

    final selected = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _TruckPreferenceSheet(
          categories: vm.categories,
          initialCategory: vm.selectedCategory,
          initialSubCategory: vm.selectedSubCategory,
          initialVariant: vm.selectedVariant,
          onSelected: (category, subCategory, variant) {
            vm.selectCategory(category);
            vm.selectSubCategory(subCategory);
            vm.selectVariant(variant);
          },
        );
      },
    );

    if (selected == true && mounted) {
      setState(() {
        truckPreferenceController.text = _truckPreferenceLabel(
          vm.selectedCategory,
          vm.selectedSubCategory,
          vm.selectedVariant,
        );
      });
    }
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
                          final locationName = result.description;
                          pickupId = result.id;
                          pickupLat = double.tryParse(result.lat ?? "");
                          pickupLng = double.tryParse(result.lng ?? "");
                          pickupAddressController.text = locationName;
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
                          final locationName = result.description;

                          dropAddressController.text = locationName;

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
                      if (vm.selectedVariant != null &&
                          truckPreferenceController.text.isEmpty) {
                        truckPreferenceController.text = _truckPreferenceLabel(
                          vm.selectedCategory,
                          vm.selectedSubCategory,
                          vm.selectedVariant,
                        );
                      }

                      return _TruckPreferenceField(
                        controller: truckPreferenceController,
                        onTap: () => _openTruckPreferenceSheet(vm),
                        validator: (value) {
                          if (vm.selectedVariant == null) {
                            return "Please select truck preference";
                          }

                          return null;
                        },
                      );
                    },
                  ),

                  SizedBox(height: 30.h),

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
                        createOrderVm.request = CreateOrderRequest(
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
                          vehicleCategoryId:
                              createOrderVm.selectedVariant?.id ?? 0,
                          budget: int.parse(budgetController.text.trim()),
                        );

                        CommonMethod.showLoadingDialog(context);
                        createOrderVm.createRide(
                          onSuccess: (v) {
                            Navigator.pop(context);
                            AppRoute.bottomBarScreen(context);
                            AppNotifier.showSuccessSnackBar(message: v);
                          },
                          onFailure: (v) {
                            Navigator.pop(context);
                            AppNotifier.showErrorSnackBar(message: v);
                          },
                          request: createOrderVm.request,
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

class _TruckPreferenceField extends StatelessWidget {
  const _TruckPreferenceField({
    required this.controller,
    required this.onTap,
    required this.validator,
  });

  final TextEditingController controller;
  final VoidCallback onTap;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Truck Preference", style: StyleUtility.inputTextStyle),
        SizedBox(height: 3.5.h),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          validator: validator,
          minLines: 1,
          maxLines: 3,
          style: StyleUtility.inputTextStyle,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(
              left: 20.w,
              top: 16,
              bottom: 16,
              right: 12.w,
            ),
            filled: true,
            fillColor: Colors.white,
            hintStyle: StyleUtility.hintTextStyle,
            hintText: "Select Truck Preference",
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ColorUtility.color767C8C,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            errorStyle: StyleUtility.errorTextStyle.copyWith(
              fontSize: TextSizeUtility.textSize13.sp,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
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

typedef _TruckPreferenceSelected =
    void Function(Data category, SubCategories subCategory, Variants variant);

class _TruckPreferenceSheet extends StatefulWidget {
  const _TruckPreferenceSheet({
    required this.categories,
    required this.initialCategory,
    required this.initialSubCategory,
    required this.initialVariant,
    required this.onSelected,
  });

  final List<Data> categories;
  final Data? initialCategory;
  final SubCategories? initialSubCategory;
  final Variants? initialVariant;
  final _TruckPreferenceSelected onSelected;

  @override
  State<_TruckPreferenceSheet> createState() => _TruckPreferenceSheetState();
}

class _TruckPreferenceSheetState extends State<_TruckPreferenceSheet> {
  Data? _selectedCategory;
  SubCategories? _selectedSubCategory;
  bool _showVariants = false;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _selectedSubCategory = widget.initialSubCategory;
  }

  void _selectCategory(Data category) {
    final subCategories = category.subCategories ?? [];
    final initialSubCategory =
        identical(category, widget.initialCategory) &&
            subCategories.contains(widget.initialSubCategory)
        ? widget.initialSubCategory
        : null;

    setState(() {
      _selectedCategory = category;
      _selectedSubCategory =
          initialSubCategory ??
          (subCategories.isNotEmpty ? subCategories.first : null);
      _showVariants = true;
    });
  }

  void _goBackToCategories() {
    setState(() {
      _showVariants = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: ColorUtility.colorF5F6FA,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 240),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: _showVariants
                      ? _buildSubCategoryAndVariantScreen()
                      : _buildCategoryScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: ColorUtility.colorE1E6EF)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _showVariants
                ? _goBackToCategories
                : () => Navigator.pop(context),
            icon: Icon(
              _showVariants
                  ? Icons.arrow_back_ios_new_rounded
                  : Icons.close_rounded,
              color: ColorUtility.color1A2530,
            ),
          ),
          Expanded(
            child: Text(
              "Select Truck Preference",
              textAlign: TextAlign.center,
              style: StyleUtility.manropeSemiBold18Color0E0E0E,
            ),
          ),
          if (_showVariants)
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close_rounded,
                color: ColorUtility.color1A2530,
              ),
            )
          else
            SizedBox(width: 48.w),
        ],
      ),
    );
  }

  Widget _buildCategoryScreen() {
    if (widget.categories.isEmpty) {
      return const _TruckPreferenceEmptyState(
        icon: Icons.local_shipping_outlined,
        title: "No truck preferences found",
        message: "Please try again in a moment.",
      );
    }

    return ListView.separated(
      key: const ValueKey("category-screen"),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      itemBuilder: (context, index) {
        final category = widget.categories[index];

        return _CategoryTile(
          category: category,
          isSelected: identical(category, _selectedCategory),
          onTap: () => _selectCategory(category),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemCount: widget.categories.length,
    );
  }

  Widget _buildSubCategoryAndVariantScreen() {
    final category = _selectedCategory;
    final subCategories = category?.subCategories ?? [];

    if (category == null) {
      return const _TruckPreferenceEmptyState(
        icon: Icons.local_shipping_outlined,
        title: "Choose a category first",
        message: "Go back and select a vehicle category.",
      );
    }

    return Column(
      key: const ValueKey("variant-screen"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
          child: _SelectedCategoryHeader(category: category),
        ),
        Expanded(
          child: subCategories.isEmpty
              ? const _TruckPreferenceEmptyState(
                  icon: Icons.view_list_outlined,
                  title: "No sub categories found",
                  message: "Please choose another category.",
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final leftWidth = constraints.maxWidth * 0.35;

                    return Row(
                      children: [
                        SizedBox(
                          width: leftWidth,
                          child: ListView.separated(
                            padding: EdgeInsets.fromLTRB(12.w, 4.h, 8.w, 24.h),
                            itemBuilder: (context, index) {
                              final subCategory = subCategories[index];

                              return _SubCategoryTile(
                                subCategory: subCategory,
                                isSelected: identical(
                                  subCategory,
                                  _selectedSubCategory,
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedSubCategory = subCategory;
                                  });
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 8.h),
                            itemCount: subCategories.length,
                          ),
                        ),
                        Container(
                          width: 1,
                          margin: EdgeInsets.only(bottom: 24.h),
                          color: ColorUtility.colorE1E6EF,
                        ),
                        Expanded(
                          child: _VariantList(
                            category: category,
                            subCategory: _selectedSubCategory,
                            initialVariant: widget.initialVariant,
                            onSelected: widget.onSelected,
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final Data category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected
                  ? ColorUtility.colorEA580C
                  : ColorUtility.colorE1E6EF,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: ColorUtility.colorEA580C.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Icon(
                  Icons.local_shipping_outlined,
                  color: ColorUtility.colorEA580C,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  category.categoryName ?? "Vehicle Category",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleUtility.manropeSemiBold16Color19191A,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: ColorUtility.color767C8C,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedCategoryHeader extends StatelessWidget {
  const _SelectedCategoryHeader({required this.category});

  final Data category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorUtility.colorE1E6EF),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_shipping_outlined,
            color: ColorUtility.colorEA580C,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              category.categoryName ?? "Vehicle Category",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: StyleUtility.manropeSemiBold14Color1A2530,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubCategoryTile extends StatelessWidget {
  const _SubCategoryTile({
    required this.subCategory,
    required this.isSelected,
    required this.onTap,
  });

  final SubCategories subCategory;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? ColorUtility.colorEA580C.withValues(alpha: 0.12)
          : Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          constraints: BoxConstraints(minHeight: 54.h),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected
                  ? ColorUtility.colorEA580C
                  : ColorUtility.colorE1E6EF,
            ),
          ),
          child: Text(
            subCategory.type ?? "Sub Category",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: StyleUtility.manropeSemiBold12Color474C59.copyWith(
              color: isSelected
                  ? ColorUtility.colorEA580C
                  : ColorUtility.color474C59,
            ),
          ),
        ),
      ),
    );
  }
}

class _VariantList extends StatelessWidget {
  const _VariantList({
    required this.category,
    required this.subCategory,
    required this.initialVariant,
    required this.onSelected,
  });

  final Data category;
  final SubCategories? subCategory;
  final Variants? initialVariant;
  final _TruckPreferenceSelected onSelected;

  @override
  Widget build(BuildContext context) {
    final selectedSubCategory = subCategory;
    final variants = selectedSubCategory?.variants ?? [];

    if (selectedSubCategory == null) {
      return const _TruckPreferenceEmptyState(
        icon: Icons.tune_outlined,
        title: "Select a sub category",
        message: "Variants will appear here.",
      );
    }

    if (variants.isEmpty) {
      return const _TruckPreferenceEmptyState(
        icon: Icons.inventory_2_outlined,
        title: "No variants found",
        message: "Please select another sub category.",
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(12.w, 4.h, 16.w, 24.h),
      itemBuilder: (context, index) {
        final variant = variants[index];

        return _VariantTile(
          variant: variant,
          isSelected: identical(variant, initialVariant),
          onTap: () {
            onSelected(category, selectedSubCategory, variant);
            Navigator.pop(context, true);
          },
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemCount: variants.length,
    );
  }
}

class _VariantTile extends StatelessWidget {
  const _VariantTile({
    required this.variant,
    required this.isSelected,
    required this.onTap,
  });

  final Variants variant;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected
                  ? ColorUtility.colorEA580C
                  : ColorUtility.colorE1E6EF,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _variantLabel(variant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleUtility.manropeSemiBold14Color1A2530,
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle_rounded,
                      color: ColorUtility.colorEA580C,
                      size: 20,
                    ),
                ],
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  _VariantInfoPill(label: "${variant.weight ?? 0} Ton"),
                  _VariantInfoPill(label: "${variant.length ?? 0} Feet"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VariantInfoPill extends StatelessWidget {
  const _VariantInfoPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorUtility.colorF0F2F9,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(label, style: StyleUtility.manropeMedium10Color6E6E6E),
    );
  }
}

class _TruckPreferenceEmptyState extends StatelessWidget {
  const _TruckPreferenceEmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 42.sp, color: ColorUtility.color767C8C),
            SizedBox(height: 12.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: StyleUtility.manropeSemiBold16Color19191A,
            ),
            SizedBox(height: 6.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: StyleUtility.manropeMedium14Color767C8C,
            ),
          ],
        ),
      ),
    );
  }
}

String _variantLabel(Variants variant) {
  return "${variant.weight ?? 0} Ton - ${variant.length ?? 0} Feet";
}

String _truckPreferenceLabel(
  Data? category,
  SubCategories? subCategory,
  Variants? variant,
) {
  final values = [
    category?.categoryName,
    subCategory?.type,
    if (variant != null) _variantLabel(variant),
  ].whereType<String>().where((value) => value.trim().isNotEmpty).toList();

  return values.join("\n");
}
