import 'package:flutter/cupertino.dart';
import 'package:regexed_validator/regexed_validator.dart';

class Validators {
  BuildContext context;

  Validators(this.context);



  String? validatorVehicleModel(value) {
    if (value.isEmpty) {
      return "Please Enter Vehicle Model";
    }
    return null;
  }


  String? validatorFirstName(value) {
    if (value.isEmpty) {
      return "Please enter your first name";
    }
    return null;
  }


  String? validatorLastName(value) {
    if (value.isEmpty) {
      return "Please enter your last name";
    }
    return null;
  }



  String? validatorFullName(value) {
    if (value.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }


  String? validatorTransporterName(value) {
    if (value.isEmpty) {
      return "Please enter transporter name";
    }
    return null;
  }


  String? validatorTransporterAddress(value) {
    if (value.isEmpty) {
      return "Please enter transporter address";
    }
    return null;
  }



  String? validatorVehicleNumber(value) {
    if (value.isEmpty) {
      return "Please Enter Vehicle Number";
    }
    return null;
  }

  String? validatorDriverName(value) {
    if (value.isEmpty) {
      return "Please Enter Driver Number";
    }
    return null;
  }

  String? validateCargoLength(value) {
    if (value.isEmpty) {
      return "Please Enter Cargo Length";
    }
    return null;
  }

  String? validateCargoWidth(value) {
    if (value.isEmpty) {
      return "Please Enter Cargo Width";
    }
    return null;
  }

  String? validateCargoHeight(value) {
    if (value.isEmpty) {
      return "Please Enter Cargo Height";
    }
    return null;
  }

  String? validateCargoCapacity(value) {
    if (value.isEmpty) {
      return "Please Enter Cargo Capacity";
    }
    return null;
  }

  String? validateLicence(value) {
    if (value.isEmpty) {
      return "Please Select Image";
    }
    return null;
  }
  String? validateMobile(value) {
    if (value.isEmpty) {
      return "Please Enter Mobile Number";
    }
    return null;
  }

  String? validateGSt(value) {
    if (value.isEmpty) {
      return "Please Enter GST  Number";
    }
    return null;
  }

  String? validatorEmail(value) {
    if (value.isEmpty) {
      return "Please Add Your Email Id";
    } else if (validator.email(value) == false) {
      return 'Invalid Email Id';
    }

    return null;
  }

  //
  // String? validatorPassword(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationPass;
  //   } else if (value.toString().length < 8) {
  //     return context.loc.validationPassLength;
  //   }
  //   return null;
  // }
  //
  // String? validatorPasswordForLogin(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationPass;
  //   }
  //   return null;
  // }
  //

  //
  // String? validatorPhone(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationPhone;
  //   }
  //   return null;
  // }
  //
  // String? validatorFirstName(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationFirstName;
  //   }
  //   return null;
  // }
  //
  // String? validatorLastName(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationLastName;
  //   }
  //   return null;
  // }
  //
  // // String? validatorGovtId(value) {
  // //   if (value.isEmpty && value.length()) {
  // //     return context.loc.validationID;
  // //   }
  // //   return null;
  // // }
  //
  // String? validatorGovtId(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationID;
  //   } else if (value.length != 9) {
  //     return context.loc.validationIDInvalid;
  //   }
  //   return null;
  // }
  //
  // String? validatorAddress(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationAddress;
  //   }
  //   return null;
  // }
  //
  // String? validatorCompanyName(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationCompanyName;
  //   }
  //   return null;
  // }
  //
  // String? validatorMinAge(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationMinAge;
  //   }
  //   return null;
  // }
  //
  //
  // String? validatorMaxAge2(String min, max) {
  //   if (max.isEmpty) {
  //     return context.loc.validationMaxAge;
  //   } else if (double.parse(max) < double.parse(min)) {
  //     return context.loc.validationMaxAgeInvalid;
  //   }
  //   return null;
  // }
  //
  // String? validatorMinWeight(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationMinWeight;
  //   } else if (double.parse(value) < 1) {
  //     return context.loc.validationMinWeightInvalid;
  //   }
  //   return null;
  // }
  //
  //
  //
  // String? validatorMaxWeight2(String min, max) {
  //   if (max.isEmpty) {
  //     return context.loc.validationMaxWeight;
  //   } else if (double.parse(max) < double.parse(min)) {
  //     return context.loc.validationMaxWeightInvalid;
  //   }
  //   return null;
  // }
  //
  //
  // String? validatorWeight(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationWeight;
  //   } else if (double.parse(value) < 1) {
  //     return context.loc.validationWeightInvalid;
  //   }
  //   return null;
  // }
  // String? validatorMinHeight(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationMinHeight;
  //   } else if (double.parse(value) < 1) {
  //     return context.loc.validationMinHeightInvalid;
  //   }
  //   return null;
  // }
  //
  //
  //
  //
  // String? validatorMaxHeight2(String min, max) {
  //   if (max.isEmpty) {
  //     return context.loc.validationMaxHeight;
  //   } else if (double.parse(max) < double.parse(min)) {
  //     return context.loc.validationMaxHeightInvalid;
  //   }
  //   return null;
  // }
  //
  //
  // String? validatorHeight(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationHeight;
  //   } else if (double.parse(value) < 1) {
  //     return context.loc.validationHeightInvalid;
  //   }
  //   return null;
  // }
  //
  //
  // String? validatorDescription(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationDescription;
  //   }
  //   return null;
  // }
  //
  // String? validatorAboutYou(value) {
  //   if (value.isEmpty) {
  //     return context.loc.validationTellAbout;
  //   }
  //   return null;
  // }
  //
  //
  // String? validatorSubject(value) {
  //   if (value.isEmpty) {
  //     return "Subject is required.";
  //   }
  //   return null;
  // }
  //
  // String? validatorMessage(value) {
  //   if (value.isEmpty) {
  //     return "Message is required.";
  //   }
  //   return null;
  // }
}
