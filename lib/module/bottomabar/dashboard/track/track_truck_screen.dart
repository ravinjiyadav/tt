//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class LiveTrackScreen extends StatelessWidget {
//   const LiveTrackScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           /// MAP (NO ROUTES)
//           const GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: LatLng(22.5726, 88.3639), // any default location
//               zoom: 14,
//             ),
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             mapToolbarEnabled: false,
//           ),
//
//           /// BACK BUTTON
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//             ),
//           ),
//
//           /// BOTTOM CARD
//           const Positioned(
//             left: 16,
//             right: 16,
//             bottom: 24,
//             child: _DriverBottomCard(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class _DriverBottomCard extends StatelessWidget {
//   const _DriverBottomCard();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           /// Driver Row
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 22,
//                 backgroundImage:
//                 NetworkImage("https://i.pravatar.cc/150?img=11"),
//               ),
//               const SizedBox(width: 12),
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Sanjay Singh",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       "No, 346GHM - Color, White",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//               _icon(Icons.chat_bubble_outline),
//               const SizedBox(width: 8),
//               _icon(Icons.call),
//             ],
//           ),
//
//           const SizedBox(height: 16),
//
//           /// Locations
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   _dot(Colors.green),
//                   Container(
//                     width: 2,
//                     height: 24,
//                     color: Colors.grey.shade300,
//                   ),
//                   _dot(Colors.orange),
//                 ],
//               ),
//               const SizedBox(width: 12),
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "HCG Eko Kancer Hospital...",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: 14),
//                     Text(
//                       "City Center Salt Lake...",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//               const CircleAvatar(
//                 backgroundColor: Color(0xFFF1F3F5),
//                 child: Icon(Icons.keyboard_arrow_down),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   static Widget _icon(IconData icon) {
//     return CircleAvatar(
//       backgroundColor: const Color(0xFFF7F8FA),
//       child: Icon(icon, color: Colors.deepOrange),
//     );
//   }
//
//   static Widget _dot(Color color) {
//     return Container(
//       width: 10,
//       height: 10,
//       decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//     );
//   }
// }
