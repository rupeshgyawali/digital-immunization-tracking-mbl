import 'package:flutter/material.dart';

TextStyle myStyle = TextStyle(fontSize: 20);

class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  String childname;
  String fathername;
  String mothername;
  String parentphonenumber;
  String value = "";
  List<DropdownMenuItem<String>> menuitems = List();
  bool disableddropdown = true;

  final province1 = {
    "1": "Bhojpur",
    "2": "Dhankuta",
    "3": "Illam",
    "4": "Jhapa",
    "5": "Khotang",
    "6": "Morang",
    "7": "Okhaldhunga",
    "8": "Panchthar",
    "9": "Sankhuwasabha",
    "10": "Solukhumbu",
    "11": "Sunsari",
    "12": "Taplejung",
    "13": "Terhathum",
    "14": "Udayapur",
  };

  final province2 = {
    "1": "Parsa",
    "2": "Bara",
    "3": "Rautahat",
    "4": "Sarlahi",
    "5": "Dhanusha",
    "6": "Siraha",
    "7": "Mahottari",
    "8": "Saptari",
  };

  final province3 = {
    "1": "Sindhuli",
    "2": "Ramechhap",
    "3": "Dolakha",
    "4": "Bhaktapur",
    "5": "Dhading",
    "6": "Kathmandu",
    "7": "Kavrepalanchok",
    "8": "Lalitpur",
    "9": "Nuwakot",
    "10": "Rasuwa",
    "11": "Sindhupalchok",
    "12": "Chitwan",
    "13": "Makwanpur",
  };
  final province4 = {
    "1": "Baglung",
    "2": "Gorkha",
    "3": "Kaski",
    "4": "Lamjung",
    "5": "Manang",
    "6": "Mustang",
    "7": "Myagdi",
    "8": "Nawalpur",
    "9": "Parbat",
    "10": "Syangja",
    "11": "Tanahun",
  };
  final province5 = {
    "1": "Kapilvastu",
    "2": "Parasi",
    "3": "Rupandehi",
    "4": "Arghakhanchi",
    "5": "Gulmi",
    "6": "Palpa",
    "7": "Dang Deukhuri",
    "8": "Pyuthan",
    "9": "Rolpa",
    "10": "Eastern Rukum",
    "11": "Banke",
    "12": "Bardiya",
  };
  final province6 = {
    "1": "Western Rukum",
    "2": "Salyan",
    "3": "Dolpa",
    "4": "Humla",
    "5": "Jumla",
    "6": "Kalikot",
    "7": "Mugu",
    "8": "Surkhet",
    "9": "Dailekh",
    "10": "Jajarkot",
  };
  final province7 = {
    "1": "Kailali",
    "2": "Achham",
    "3": "Doti",
    "4": "Bajhang",
    "5": "Bajura",
    "6": "Kanchanpur",
    "7": "Dadeldhura",
    "8": "Baitadi",
    "9": "Darchula",
  };

  void populateprovince1() {
    for (String key in province1.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(province1[key]),
        ),
        value: province1[key],
      ));
    }
  }

  void populateprovince2() {
    for (String key in province2.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(province2[key]),
        ),
        value: province2[key],
      ));
    }
  }

  void populateprovince3() {
    for (String key in province3.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(province3[key]),
        ),
        value: province3[key],
      ));
    }
  }

  void populateprovince4() {
    for (String key in province4.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(province4[key]),
        ),
        value: province4[key],
      ));
    }
  }

  void populateprovince5() {
    for (String key in province5.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(province5[key]),
        ),
        value: province5[key],
      ));
    }
  }

  void populateprovince6() {
    for (String key in province6.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(province6[key]),
        ),
        value: province6[key],
      ));
    }
  }

  void populateprovince7() {
    for (String key in province7.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(province7[key]),
        ),
        value: province7[key],
      ));
    }
  }

  void selected(_value) {
    if (_value == "Province 1") {
      menuitems = [];
      populateprovince1();
    } else if (_value == "Province 2") {
      menuitems = [];
      populateprovince2();
    } else if (_value == "Province 3") {
      menuitems = [];
      populateprovince3();
    } else if (_value == "Province 4") {
      menuitems = [];
      populateprovince4();
    } else if (_value == "Province 5") {
      menuitems = [];
      populateprovince5();
    } else if (_value == "Province 6") {
      menuitems = [];
      populateprovince6();
    } else if (_value == "Province 7") {
      menuitems = [];
      populateprovince7();
    }
    setState(() {
      value = _value;
      disableddropdown = false;
    });
  }

  void secondselected(_value) {
    setState(() {
      value = _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final childnameField = TextField(
      onChanged: (val) {
        setState(() {
          childname = val;
        });
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "Child Name",
          hintStyle: TextStyle(
            fontSize: 20.0,
          ),
          icon: Icon(Icons.child_care_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
    );
    final fathernameField = TextField(
      onChanged: (val) {
        setState(() {
          fathername = val;
        });
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "Father Name",
          hintStyle: TextStyle(
            fontSize: 20.0,
          ),
          icon: Icon(Icons.person_outline_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
    );
    final mothernameField = TextField(
      onChanged: (val) {
        setState(() {
          mothername = val;
        });
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "Mother Name",
          hintStyle: TextStyle(
            fontSize: 20.0,
          ),
          icon: Icon(Icons.person_outline_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
    );
    final parentphonenumberField = TextField(
      onChanged: (val) {
        setState(() {
          parentphonenumber = val;
        });
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "Parent Phone Number",
          hintStyle: TextStyle(
            fontSize: 20.0,
          ),
          icon: Icon(Icons.phone_android_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
    );
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'CHILD REGISTER',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    childnameField,
                    SizedBox(
                      height: 10,
                    ),
                    fathernameField,
                    SizedBox(
                      height: 10,
                    ),
                    mothernameField,
                    SizedBox(
                      height: 10,
                    ),
                    parentphonenumberField,
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                        alignment: FractionalOffset(0.03, 0.0),
                        child: Container(
                          child: Text(
                            "ADDRESS",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: FractionalOffset(0.03, 0.0),
                      child: Container(
                          padding: const EdgeInsets.only(
                            left: 6.0,
                            right: 0.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                          ),
                          child: DropdownButtonHideUnderline(
                              child: Column(
                            children: <Widget>[
                              DropdownButton<String>(
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "Province 1",
                                    child: Center(
                                      child: Text("Province 1"),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Province 2",
                                    child: Center(
                                      child: Text("Province 2"),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Province 3",
                                    child: Center(
                                      child: Text("Province 3"),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Province 4",
                                    child: Center(
                                      child: Text("Province 4"),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Province 5",
                                    child: Center(
                                      child: Text("Province 5"),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Province 6",
                                    child: Center(
                                      child: Text("Province 6"),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Province 7",
                                    child: Center(
                                      child: Text("Province 7"),
                                    ),
                                  ),
                                ],
                                onChanged: (_value) => selected(_value),
                                hint: Text('Province',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                              Text(
                                "$value",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: FractionalOffset(0.03, 0.0),
                      child: Container(
                          padding: const EdgeInsets.only(
                            left: 6.0,
                            right: 0.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                          ),
                          child: DropdownButtonHideUnderline(
                              child: Column(
                            children: <Widget>[
                              DropdownButton<String>(
                                items: menuitems,
                                onChanged: disableddropdown
                                    ? null
                                    : (_value) => secondselected(_value),
                                hint: Text('District',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                              Text(
                                "$value",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ))),
      ),
    );
  }
}
