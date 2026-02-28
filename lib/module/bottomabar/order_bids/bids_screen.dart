import 'package:book_your_truck/utilities/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_circular_loader_widget.dart';
import 'bids_model.dart';
import 'bids_vm.dart';

class BidsScreen extends StatefulWidget {

 final int id;
  const BidsScreen({super.key, required this.id});

  @override
  State<BidsScreen> createState() => _BidsScreenState();
}

class _BidsScreenState extends State<BidsScreen> {
  late BidsVm bidsVm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bidsVm = Provider.of<BidsVm>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bidsVm.getBidsList(
        id: widget.id,
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
      appBar: AppBar(title: const Text("Bids")),
      body: Consumer<BidsVm>(
        builder: (context, provider, child) {
          return provider.isLoading == true
              ? CustomCircularLoaderWidget()
              : provider.bidsModel.data?.isEmpty ?? true
              ? Center(child: NoDataWidget())
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.bidsModel.data?.length,
                  itemBuilder: (context, index) {
                    final data = provider.bidsModel.data?[index];
                    return BidCard(bid: data!);
                  },
                );
        },
      ),
    );
  }
}

class BidCard extends StatelessWidget {
  final BidsData bid;

  const BidCard({super.key, required this.bid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// VEHICLE NAME
          Row(
            children: [
              const Icon(Icons.local_shipping, color: Colors.orange),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  bid.vehicleDisplayInfo ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// PRICE + ETA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹ ${bid.quotedPrice ?? ""}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.timer, size: 18),
                  const SizedBox(width: 5),
                  Text("${bid.estimatedTimeMin} mins"),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// PICKUP TIME
          Row(
            children: [
              const Icon(Icons.access_time, size: 18),
              const SizedBox(width: 6),
              Text("${bid.pickupTimeOffered}"),
            ],
          ),

          const SizedBox(height: 12),

          /// BID DETAILS
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              bid.bidDetails ?? "",
              style: const TextStyle(fontSize: 13),
            ),
          ),

          const SizedBox(height: 16),

          /// BUTTONS
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("View Profile"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Select Bid"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
