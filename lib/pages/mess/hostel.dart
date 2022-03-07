class Hostel{

  Hostel(this.hostelName,this.messes);
  String hostelName;
  List<Mess> messes;

}

class Mess{
  Mess(this.bills,this.menu,this.complaintsAndSuggestions);
  List bills;
  List menu;
  List complaintsAndSuggestions;
}