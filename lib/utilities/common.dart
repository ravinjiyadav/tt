import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'color_utility.dart';

class CommonMethod {
  CommonMethod._();
//
// Common  static const dateFormatForAddDate = 'dd/MM/yyyy';
//
//   static const dateFormatForbirthday = 'yyyy-MM-dd';
//
//   static const dateFormat = 'dd/MM/yyyy hh:mm a';



  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }



  static Future<bool?> showErrorToast(BuildContext context, String message) {

    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<bool?> showSuccessToast(BuildContext context, String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }



  //Show loading dialog
  static showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(ColorUtility.colorEA580C),
                        strokeWidth: 2.0,
                      ),
                      /*Platform.isAndroid
                      ? */
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          "Please wait...",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      )
//                      : SizedBox(),
                    ]),
              ),
            ));
      },
    );
  }



// static selectDate(
//     BuildContext context, TextEditingController dateController) async {
//   final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2090),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: ColorScheme.light().copyWith(
//               primary: ColorUtility.color263287,
//               // Set the primary color
//               onPrimary: Colors.white, // Set the text color
//             ),
//             dialogBackgroundColor: Colors.white, // Set the background color// Set the background color
//           ),
//           child: child!,
//         );
//       }
//
//       );
//   if (selected != null) {
//     String formattedDate = DateFormat(dateFormatForAddDate).format(selected);
//     dateController.text = formattedDate;
//   }
// }

// static selectTime(
//     BuildContext context, TextEditingController timeController) async {
//   final TimeOfDay? selected = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay(hour: 7, minute: 15),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: const ColorScheme.light().copyWith(
//               primary: ColorUtility.color263287,
//               // Set the primary color
//               onPrimary: Colors.white, // Set the text color
//             ),
//             dialogBackgroundColor: Colors.white, // Set the background color
//           ),
//           child: child!,
//         );
//       });
//   if (selected != null) {
//     timeController.text = "${selected.hour}:${selected.minute}";
//   }
// }

// static selectDateOfBirth(
//     BuildContext context, TextEditingController dateController) async {
//   final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: ColorScheme.light().copyWith(
//               primary: ColorUtility.color263287,
//               // Set the primary color
//               onPrimary: Colors.white, // Set the text color
//             ),
//             dialogBackgroundColor: Colors.white, // Set the background color
//           ),
//           child: child!,
//         );
//       });
//   if (selected != null) {
//   //  String formattedDate = DateFormat(dateFormatForAddDate).format(selected);
//     String formattedDate = DateFormat(dateFormatForbirthday).format(selected);
//   //  String formattedDate = selected.toString();
//     dateController.text = formattedDate;
//   }
// }
//
// static String getDateFromDayMonthYear(int? year, month, day){
//
//   if(year != null && month != null && day != null ){
//     DateTime date = DateTime(year, month, day);
//
//     // Format the DateTime object
//     String formattedDate = DateFormat(dateFormatForbirthday).format(date);
//
//     // Print the formatted date
//     print('Formatted Date: $formattedDate');
//
//     return formattedDate;
//   }else{
//     return "";
//   }


// }
}
