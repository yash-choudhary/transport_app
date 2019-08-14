class usermodel{
  int type=1;
  // 1:fleet owner
  // 2:transporter
  // 3:freight owner
  String name;
  String cin;
  String gstin;
  int contact;
  String address;
  int pincode;

  usermodel(this.type,this.name,this.cin,this.gstin,this.contact,this.address,this.pincode);

}