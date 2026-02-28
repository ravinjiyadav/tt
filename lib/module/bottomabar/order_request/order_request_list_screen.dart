import 'package:book_your_truck/routes/app_routes.dart';
import 'package:book_your_truck/utilities/app_notifier.dart';
import 'package:book_your_truck/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utilities/enums.dart';
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
    // TODO: implement initState
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
    //  appBar: AppBar(title: const Text("Created Order Request")),

      appBar:commonAppBar(title: "Created Order Request"),
      body: SafeArea(
        child: Consumer<OrderRequestListVm>(builder: (context, provider, child){
        
          return  provider.isLoading == true
              ? CustomCircularLoaderWidget()
              :
        
        
        
        
          provider.orderRequestModel.order?.isEmpty ?? true ?
        
          Center(child: NoDataWidget(),) :
        
        
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.orderRequestModel.order?.length,
            itemBuilder: (context, index) {
              final data = provider.orderRequestModel.order?[index];
              return LoadCard(order: data!);
            },
          );
        
        }),
      )



    );
  }
}

class LoadCard extends StatelessWidget {

  final Order order;

  const LoadCard({super.key, required this.order});

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
          /// STATUS + BUDGET
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                "₹ ${order.budgetRangeMin} - ${order.budgetRangeMax}",
                style: StyleUtility.manropeSemiBold16Color19191A.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),

              ),
            ],
          ),

          const SizedBox(height: 14),

          /// PICKUP → DROPOFF
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.orange),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "${order.pickupCity}  →  ${order.dropoffCity}",

                  style: StyleUtility.manropeMedium16Color1E1E2D,



                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// CARGO INFO
          Row(
            children: [
              const Icon(Icons.local_shipping, size: 18),
              const SizedBox(width: 6),
              Text(
                "${order.cargoWeight} Ton | ${order.preferredVehicleType}",
                style: StyleUtility.manropeMedium14Color719191A,
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// DATE & TIME
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 18),
              const SizedBox(width: 6),
              Text(
                "${order.pickupDate} | ${order.pickupTimePreference}",
                style: StyleUtility.manropeMedium14Color719191A,
              ),
            ],
          ),

          const SizedBox(height: 10),



          /// BIDS
          Row(
            children: [
              const Icon(Icons.gavel, size: 18),
              const SizedBox(width: 6),
              Text("${order.bidCount} Bids",  style: StyleUtility.manropeMedium14Color719191A,),
            ],
          ),

          const SizedBox(height: 16),

          /// BUTTONS
          CustomButton(

            type: ButtonType.border,
            onTap: () {

              if((order.bidCount ?? 0) > 0){
                AppRoute.bidsScreen(context, order.id ?? 0);
              }else{

                AppNotifier.showInfoSnackBar(message: "No bids yet");
              }
            },
            buttonText: "View Bids",),

          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
