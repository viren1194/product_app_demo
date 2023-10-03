class AppConstant {
  static const String BASEURL = 'https://api.escuelajs.co/api/v1/';
  static const String GETPRODUCT = '${BASEURL}products';
  static const String GETCATEGORY = '${BASEURL}categories';
  static const String LOGINURL = "${BASEURL}auth/login";
  static const String PROFILE = "${BASEURL}auth/profile";
   static const String SEARCH = 'products/?title=';

  // static const String LOGIN = '${BASEURL}auth/login';
  static const String LOGIN = 'https://reqres.in/api/login';

  /// key

  static const String CREATEUSER = "https://api.escuelajs.co/api/v1/users/";
  //shared key
  static const String USERID = 'userId';
  static const String USERTOKEN = 'userToken';
  static const String ISUSERLOGIN = 'userLogin';
}
