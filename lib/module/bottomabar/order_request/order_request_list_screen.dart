import 'package:book_your_truck/utilities/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/color_utility.dart';
import '../../../utilities/style_utility.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/custom_circular_loader_widget.dart';
import 'model/order_request_model.dart';
import 'order_request_list_vm.dart';

class LoadListScreen extends StatefulWidget {
  const LoadListScreen({super.key});

  @override
  State<LoadListScreen> createState() => _LoadListScreenState();
}

class _LoadListScreenState extends State<LoadListScreen> {
  late OrderRequestListVm orderRequestListVm;

  @override
  void initState() {
    super.initState();

    orderRequestListVm = Provider.of<OrderRequestListVm>(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderRequestListVm.getCreatedOrderList(
        onSuccess: (message) {},
        onFailure: (message) {
          AppNotifier.showErrorSnackBar(message: message);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorF5F6FA,
      appBar: commonAppBar(title: "Created Order Request"),
      body: SafeArea(
        child: Consumer<OrderRequestListVm>(
          builder: (context, provider, child) {
            final orders = provider.orderRequestModel.data ?? [];

            return provider.isLoading == true
                ? const CustomCircularLoaderWidget()
                : orders.isEmpty
                ? Center(child: NoDataWidget())
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return LoadCard(order: orders[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}

class LoadCard extends StatelessWidget {
  final Data order;

  const LoadCard({super.key, required this.order});

  String get _pickupLocation => order.pickupPlaceName?.trim().isNotEmpty == true
      ? order.pickupPlaceName!
      : order.pickupAddress ?? "N/A";

  String get _dropoffLocation =>
      order.dropoffPlaceName?.trim().isNotEmpty == true
      ? order.dropoffPlaceName!
      : order.dropoffAddress ?? "N/A";

  String get _status =>
      order.status?.trim().isNotEmpty == true ? order.status! : "Created";

  String get _vehicleInfo {
    final category = order.vehicleCategory;
    final details = <String>[
      if (category?.bodyType?.trim().isNotEmpty == true) category!.bodyType!,
      if (category?.wheels?.trim().isNotEmpty == true)
        "${category!.wheels} Wheels",
      if (category?.weight != null) "${category!.weight} Ton",
      if (category?.length != null) "${category!.length} Feet",
    ];

    return details.isEmpty ? "Vehicle not available" : details.join(" | ");
  }

  String get _cargoInfo {
    final details = <String>[
      if (order.cargoMaterial?.trim().isNotEmpty == true) order.cargoMaterial!,
      if (order.cargoDescription?.trim().isNotEmpty == true)
        order.cargoDescription!,
    ];

    return details.isEmpty ? "Cargo not available" : details.join(" | ");
  }

  String get _createdAt => _formatReadableDate(order.createdAt);

  String _formatReadableDate(String? value) {
    if (value?.trim().isNotEmpty != true) {
      return "N/A";
    }

    final dateTime = DateTime.tryParse(value!.trim())?.toLocal();
    if (dateTime == null) {
      return value;
    }

    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, "0");
    final period = dateTime.hour >= 12 ? "PM" : "AM";

    return "${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}, "
        "$hour:$minute $period";
  }

  Color get _statusColor {
    switch (_status.toLowerCase()) {
      case "active":
      case "created":
      case "open":
        return const Color(0xFF198754);
      case "completed":
      case "selected":
        return ColorUtility.colorEA580C;
      case "cancelled":
      case "expired":
        return ColorUtility.colorE03939;
      default:
        return ColorUtility.color1F2937;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorUtility.colorE1E6EF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order #${order.id ?? "-"}",
                      style: StyleUtility.manropeRegular14Color8D98AF,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹ ${order.totalExpectedAmount ?? 0}",
                      style: StyleUtility.manropeSemiBold18Color0E0E0E.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusChip(label: _status, color: _statusColor),
            ],
          ),

          const SizedBox(height: 16),

          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 10,
                  child: Column(
                    children: [
                      _RouteDot(color: ColorUtility.colorEA580C),
                      Expanded(
                        child: Container(
                          width: 1,
                          color: ColorUtility.colorE1E6EF,
                        ),
                      ),
                      _RouteDot(color: const Color(0xFF198754)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      _RouteText(label: "Pickup", value: _pickupLocation),
                      const SizedBox(height: 14),
                      _RouteText(label: "Drop off", value: _dropoffLocation),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: ColorUtility.colorE1E6EF),
          const SizedBox(height: 14),

          _InfoRow(
            icon: Icons.local_shipping_outlined,
            label: "Vehicle",
            value: _vehicleInfo,
          ),

          const SizedBox(height: 12),

          _InfoRow(
            icon: Icons.inventory_2_outlined,
            label: "Cargo",
            value: _cargoInfo,
          ),

          const SizedBox(height: 12),

          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: "Created",
            value: _createdAt,
          ),

          const SizedBox(height: 16),

          // Row(
          //   children: [
          //     Expanded(child: _BidChip(count: order.bidCount ?? 0)),
          //     const SizedBox(width: 12),
          //     SizedBox(
          //       height: 42,
          //       child: ElevatedButton(
          //         onPressed: () {
          //           if ((order.bidCount ?? 0) > 0) {
          //             AppRoute.bidsScreen(context, order.id ?? 0);
          //           } else {
          //             AppNotifier.showInfoSnackBar(message: "No bids yet");
          //           }
          //         },
          //         style: ElevatedButton.styleFrom(
          //           elevation: 0,
          //           backgroundColor: ColorUtility.colorEA580C,
          //           foregroundColor: Colors.white,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           padding: const EdgeInsets.symmetric(horizontal: 18),
          //         ),
          //         child: const Text(
          //           "View Bids",
          //           maxLines: 1,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: StyleUtility.manropeSemiBold12ColorBlack.copyWith(color: color),
      ),
    );
  }
}

class _RouteDot extends StatelessWidget {
  final Color color;

  const _RouteDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _RouteText extends StatelessWidget {
  final String label;
  final String value;

  const _RouteText({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 66,
          child: Text(label, style: StyleUtility.manropeRegular14Color8D98AF),
        ),
        Expanded(
          child: Text(
            value,
            style: StyleUtility.manropeMedium14Color719191A.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: ColorUtility.colorEA580C),
        const SizedBox(width: 10),
        SizedBox(
          width: 66,
          child: Text(label, style: StyleUtility.manropeRegular14Color8D98AF),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: StyleUtility.manropeMedium14Color719191A,
          ),
        ),
      ],
    );
  }
}
