class StringConstants {
  static const String curenncy = '\u{20B9}';
  static const String applicationName = "SARPL";
  static const String appVersion = "v1.0.0";
  static const String hello = "Hello";
  static const String request = "Kindly login to your account";
  static const String kLogin = "Login";
  static const String kChangePwd = "Change Password";
  static const String kChangeMpin = "Change Mpin";
  static const String kNext = "Next";
  static const String kVerify = "Verify";
  static const String kBack = "Back";
  static const String kMpin = "MPIN";
  static const String kUserName = "User Name";
  static const String kPassword = "Password";
  static const String kOldPassword = "Old Password";
  static const String kNewPassword = "New Password";
  static const String kConfirmPassword = "Confirm Password";
  static const String kForgotPassword = "Forgot Password ?";
  static const String kSetMpinFirst = "Set MPIN First";
  static const String kSetMpin = "Set MPIN";
  static const String kForgotMpin = "Forgot MPIN ?";
  static const String kNewMpin = "New Mpin";
  static const String kConfirmMpin = "Confirm Mpin";
  static const String kResendCode = "Resend Code";
  static const String kMobileNo = "Mobile Number";
  static const String kVerifyMobNum = "Verify Mobile Number";
  static const String kOTPSent = "OTP Sent to *******";
  static const String kSearchPlaceHolder =
      "Search Mobile or Loan or Vehicle No or Customer ID";
  static const String kServiceSearchPlaceHolder =
      "Search Mobile or Loan or Vehicle No or Customer Name or Pan No";
  static const String kCollection = "Collection";
  static const String kPropForSelltement = "Proposal for settlement";
  static const String kViewLoanDetails = "View-Loan Details";
  static const String kSendSMSLink = "Send SMS Payment Link";
  static const String kOk = "Ok";
  static const String kCancel = "Cancel";
  static const String kResend = "Resend";
  static const String kSubmit = "Submit";
  static const String kLoading = "Loading...";
  static const String kGetMenu = "Get Menu Details.";
  static const String kGetKYCLanguage = "Get KYC & Language";
  static const String kVehicleNo = "Vehicle Number";
  static const String kArrearOpening = "Arrear Opening";
  static const String kLoanNo = "Loan Number";
  static const String kMonthInstDue = "Month Inst. Due";
  static const String kEMIReceived = "EMI Received";
  static const String kNoDataFound = "No Data Found.";
  static const String kCurrentPersEmailID = "Current Personal Email ID";
  static const String kNewPersEmailID = "New Personal Email ID";
  static const String kBorrowePrefLag = "Borrower Preffered Language";
  static const String kNatureofNumber = "Primary No";
}

class ErrorMSGConstants {
  static const String kUserEmpty = "Please enter user name.";
  static const String kVerificationCodeLengthMSG =
      "Verification code should be contain 6 charactors.";
  static const String kMpinLengthMSG = "Mpin should be contain 4 charactors.";
  static const String kConfiMpinLengthMSG =
      "Confirm Mpin should be contain 4 charactors.";
  static const String kMpinNotMatchMSG =
      "New Mpin and Confirm Mpin do not match.";
  static const String sequenceNumberNotAllowed = "Sequence Number not allowed";
}

class AppVersion {
  static const String appVesrion = "1.0.0";
}

class TimeStemp {
  static String timeStemp = DateTime.now().millisecondsSinceEpoch.toString();
}

class ErrorResponseConstants {
  static const String kPasswordExpiry = "Password Expired";
}

class ViewLoanDetailsConstants {
  static const String kBorrowerName = "Borrower Name";
  static const String kBorrowerAddress = "Borrower Address";
  static const String kContactNo = "Contact Number";
  static const String kVehicleNo = "Vehicle Number";
  static const String kVehicleDesc = "Vehicle Description";
  static const String kLoanAmt = "Loan Amount";
  static const String kODPOS = "OD POS (Month Opening)";
  static const String kAgreementDate = "Agreement Date";
  static const String kLastDueDate = "Last Due Date";
  static const String kAgreementVal = "Agreement Value";
  static const String kCumulativeCTDate = "Cumulative Collection Till Date";
  static const String kCumulativeArrear = "Cumulative Arrear (INST + EXP + DP)";
  static const String kLoanStatus = "Loan Status";
  static const String kProductExeName = "Product Executive Name";
  static const String kProductExeMN = "Product Executive Mobile Number";
  static const String kGurantorCode = "Gurantor Code";
  static const String kGurantorName = "Gurantor Name";
  static const String kGurantorAddress = "Gurantor Address";
  static const String kGurantorMN = "Gurantor Mobile Number";
  static const String kCoAppCode = "Co-Applicate Code";
  static const String kCoAppName = "Co-Applicate Name";
  static const String kCoAppAddress = "Co-Applicate Address";
  static const String kCoAppMN = "Co-Applicate Mobile Number";
}

class CollectionStrings {
  static const String kInstrumentTyp = "Instrument Type";
  static const String kLoanDetails = "Loan Details";
  static const String kInstrumentAmt = "Instrument Amount";
  static const String kInstrumentNo = "Instrument Number";
  static const String kInstrumentDate = "Instrument Date";
  static const String kInstrumentBank = "Instrument Bank";
  static const String kBnkBranch = "Bank Branch";
  static const String kBorrowerAltNo = "Borrower Alternate Number";
  static const String kBorrowerRel = "Borrower Relationship";
  static const String kAmount = "Amount";
  static const String kTPin = "TPin";
}

class LastTransactionStrings {
  static const String kTitle1 = "Loan Details";
  static const String kTitle2 = "Bank Details";
  static const String kInstrumentTyp = "Instrument Type";
  static const String kInstrumentNo = "Instrument Number";
  static const String kInstrumentDate = "Instrument Date";
  static const String kBankName = "Bank Name";
  static const String kBnkBranch = "Bank Branch";
  static const String kName = "Name";
  static const String kLoanNo = "Loan Number";
  static const String kAmount = "Amount";
  static const String kVehicleNo = "Vehicle Number";
  static const String kMobileNo = "Mobile Number";
  static const String kNewMobileNo = "New Mobile Number";
}

class AppBarConstants {
  static const String kMyCustomer = "My Customer";
  static const String kViewLoan = "View Loan Details";
  static const String kCollection = "Collection";
  static const String kService = "Service";
  static const String kChangeRequestService = "Change Request Service";
  static const String kLastTrans = "Last Transaction";
  static const String kSProposalSetlApprvlRejec =
      "Proposal for Settlement Approval Rejection";
}

class ChangeRequestConstants {
  static const String kAvablNumber = "Available Number";
  static const String kRelnshp = "Relationship";
  static const String kNewMN = "New Mobile Number";
  static const String kBorwerPrefLang = "Borrower Preffered Languange";
  static const String kAddressLine1 = "Address Line 1";
  static const String kAddressLine2 = "Address Line 2";
  static const String kLandmark1 = "Landmark 1";
  static const String kLandmark2 = "Landmark 2";
  static const String kPincode = "Pincode";
  static const String kState = "State";
  static const String kCity = "City";
  static const String kArea = "Area";
  static const String kTaluk = "Taluk";
  static const String kPermanentAddress = "Permanent Address";
  static const String kSameAsPermanentAddress = "Same As Permanent Address";
  static const String kCorrespondanceAddress = "Correspondance Address";
  static const String kAddressProof = "Address Proof";
  static const String kAadharCard = "Aadhar Card";
  static const String kDocNo = "Document Number";
  static const String kSelectKYCDocProof = "Select KYC Doc Proof";
  static const String kCaptureReqLetter = "Capture Request Letter";
  static const String kDownloadReqLetter = "Download Request Letter";
  static const String kCapture = "Capture";
  static const String kYes = "Yes";
  static const String kNo = "No";
  static const String kFront = "Front";
  static const String kBack = "Back";
  static const String kSelf = "Self";
  static const String kSelfAltn = "Self-Alternate";
  static const String kManager = "Manager";
  static const String kWife = "Wife";
  static const String kDriver = "Driver";
  static const String kSon = "Son";
  static const String kFather = "Father";
}