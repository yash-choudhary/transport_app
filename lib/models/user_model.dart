class usermodel{
  static  int type;
  static String uid;
  static String category;
  // 1:fleet owner
  // 2:transporter
  // 3:freight owner
  static  String name;
  static  String cin;
  static  String gstin;
  static  int contact;
  static  String address;
  static  int pincode;

  static setData(itype,iname,icategory,icin,igstin,icontact,iaddress,ipincode){
    type = itype;
    name = iname;
    category = icategory;
    cin = icin;
    gstin = igstin;
    contact = icontact;
    address = iaddress;
    pincode = ipincode;
  }

}