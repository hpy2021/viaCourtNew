class AppStrings {
  static  RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  // http://4b57e37263e5.ngrok.io
  // static const String BASE_URL = "http://4b57e37263e5.ngrok.io/";
  // static const String IMGBASE_URL = "http://4b57e37263e5.ngrok.io/";


  static const String BASE_URL = "https://viacourts.indapoint.in/";
  static const String IMGBASE_URL = "https://viacourts.indapoint.in/";
  static const String COURT_URL = BASE_URL + "api/pitch/getCourts";
  static const String COOCKIE = "COOKIE";
  static const String TOKEN_KEY = "Token";
  static const String REGISTRATION_URL = BASE_URL + "register";
  static const String USER_URL = BASE_URL + "user";
  static const String LOGIN_URL = BASE_URL + "login";
  static const String PITCHES_URL = BASE_URL + "api/getPitches";
  static const String PITCH_TIME_SLOT_URL = BASE_URL + "api/timeSlots";
  static const String PRODUCT_URL = BASE_URL + "api/getServices";
  static const String AVAILABILITY_URL = BASE_URL + "api/pitches";
  static const String BOOKING_CONFIRM_URL = BASE_URL + "api/createBooking";
  static const String ADD_TO_CART = BASE_URL + "api/addToCart";
  static const String BOOKING_URL = BASE_URL + "api/getBookings";
  static const String MYBOOKING_URL = BASE_URL + "api/yourBookings";
  static const String HISTORY_BOOKING_URL = BASE_URL + "api/getBookingsHistory";
  static const String LOGOUT_URL = BASE_URL + "logout";
  static const String CART_URL = BASE_URL + "api/cart";
  static const String DECREMENT_URL = BASE_URL + "api/cartDecrement";
  static const String CHANGEING_STATUS_URL = BASE_URL + "api/confirmBooking";






  static const String emailHintText = "Enter Your Email or Phone";
  static const String passWordHintText = "Password";
  static const String remindMeText = "Remind me";
  static const String forgotPassText = "Forget Password?";
  static const String loginButtonText = "Login";
  static const String signInText = "Sign In";
  static const String signUpText = "Sign Up";
  static const String DonhaveaccountUpText = "Don't have an account? ";
  static const String haveaccountUpText = "You have an account? ";
  static const String firstNameText = "FirstName";
  static const String lastNameText = "LastName";
  static const String emailText = "Email";
  static const String phoneText = "Phone";
  static const String createPasswordText = "Create Password";
  static const String confirmPasswordText = "Confirm Password";
  static const String selectCourttext = "Select Court";
  static const String selectCourttextSize = "Select Pitch Size";
  static const String listofCourttextsize = "List of pitch size";
  static const String listofCourttext = "List of court";
  static const String widthText = "Width";
  static const String pitchNameText = "Pitch Name";
  static const String sizeText = "Size";
  static const String lengthText = "Length";
  static const String SeeLawText = "See Law";
  static const String homeText = "Home";
  static const String bookingText = "Booking";
  static const String activityText = "Activity";
  static const String changePasswordText = "Change Password";
  static const String meText = "Me";
  static const String selectSlot = "Select Slot";
  static const String selectdate = "Select Date";
  // static const String selectdate = "Select Date";
  static const String bookingConfirmedText = "Booking Confirmed";
  static const String reviewbookingText = "Review Booking";
  static const String confirmBookingText = "Confirm Booking";
  static const String continueText = "Continue";
  static const String bookText = "Book";
  static const String productsText = "Products";
  static const String cartText = "Cart";
  static const String proceedToCheckOutText = "Proceed to Checkout";
  static const String checkOutText = "Checkout";
  static const String payText = "Pay";
  static const String confirmationText = "Confirmation";
  static const String confirmText = "Confirm";
  static const String doneText = "Done";

  static const String currentPassText = "Current Password";
  static const String newPassText = "New Password";
  static const String privacyPolicyText = "Privacy Policy";

  static const String termsandconditionText = "Terms & Condition";


}
