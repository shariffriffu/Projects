import 'dart:convert';

Epos eposFromJson(String str) => Epos.fromJsonString(str);

String eposToJson(Epos data) => json.encode(data.toJson());

class Epos {
  String login_screen;
  String distributor_screen;
  String HelpOption;
 String aboutUsOption = "";
  String contactUsOption = "";
  String recharge_screen = "";
  String transfer_screen = "";
  String retailerBalance_screen = "";
  String addRetailer_screen = "";
  String deleteRetailer_screen = "";
  String debit_screen = "";
  String changeRetailerPassword_screen = "";
  String reports_screen = "";
  
  Epos({
    required this.login_screen,
    required this.distributor_screen,
    required this.HelpOption,
    required this.aboutUsOption,
    required this.contactUsOption,
    required this.recharge_screen,
    required this.transfer_screen,
    required this.retailerBalance_screen,
    required this.addRetailer_screen,
    required this.deleteRetailer_screen,
    required this.debit_screen,
    required this.changeRetailerPassword_screen,
    required this.reports_screen
  });

  factory Epos.fromJson(Map<String, dynamic> json) => Epos(
        login_screen: json["login_screen"] ?? "",
        distributor_screen: json["distributor_screen"] ?? "",
        HelpOption: json["help"] ?? "",
        aboutUsOption: json["aboutUs"] ?? "",
        contactUsOption: json["contactUs"] ?? "",
        recharge_screen: json["recharge_screen"] ?? "",
        transfer_screen: json["transfer_screen"] ?? "",
        retailerBalance_screen: json["retailerBalance_screen"] ?? "",
        addRetailer_screen: json["addRetailer_screen"] ?? "",
        deleteRetailer_screen: json["deleteRetailer_screen"] ?? "",
        debit_screen: json["debit_screen"] ?? "",
        changeRetailerPassword_screen: json["changeRetailerPassword_screen"] ?? "",
        reports_screen: json["reports_screen"] ?? "",
      );

  static Epos fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Epos.fromJson(jsonMap);
  }

  Map<String, dynamic> toJson() => {
        "login_screen": login_screen,
        "distributor_screen": distributor_screen,
        "recharge_screen": recharge_screen,
        "transfer_screen": transfer_screen,
        "addRetailer_screen": addRetailer_screen,
        "deleteRetailer_screen": deleteRetailer_screen,
        "debit_screen": debit_screen,
        "changeRetailerPassword_screen": changeRetailerPassword_screen,
        "reports_screen": reports_screen
      };
}
