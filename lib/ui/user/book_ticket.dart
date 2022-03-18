import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:toast/toast.dart';

class BookTickets extends StatefulWidget {
  const BookTickets(
      {Key? key,
      required this.monumentName,
      required this.uid,
      required this.amountperadult,
      required this.amountperchild,
      required this.city,
      required this.state,
      required this.mainPic,
      required this.operatorID})
      : super(key: key);

  @override
  State<BookTickets> createState() => _BookTicketsState();
  final String monumentName;
  final String uid;
  final int amountperadult;
  final int amountperchild;
  final String city;
  final String state;
  final String mainPic;
  final String operatorID;
}

class _BookTicketsState extends State<BookTickets> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  var total = 0;
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = TextEditingController();
  TextEditingController _adult = TextEditingController();
  TextEditingController _child = TextEditingController();
  TextEditingController _amount = TextEditingController();

  bool showaddmembers = false;
  String time = "";
  List<ItemLists> itemsL = [];

  final _formkey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> timeItems = [
    DropdownMenuItem(child: Text("10 AM"), value: "10 AM"),
    DropdownMenuItem(child: Text("11 AM"), value: "11 AM"),
    DropdownMenuItem(child: Text("12 AM"), value: "12 AM"),
    DropdownMenuItem(child: Text("1 PM"), value: "1 PM"),
    DropdownMenuItem(child: Text("3 PM"), value: "3 PM"),
    DropdownMenuItem(child: Text("4 PM"), value: "4 PM"),
  ];
  List<DropdownMenuItem<String>> adultItems = [
    DropdownMenuItem(child: Text("1"), value: "1"),
    DropdownMenuItem(child: Text("2"), value: "2"),
    DropdownMenuItem(child: Text("3"), value: "3"),
    DropdownMenuItem(child: Text("4"), value: "4"),
    DropdownMenuItem(child: Text("5"), value: "5"),
    DropdownMenuItem(child: Text("6"), value: "6"),
    DropdownMenuItem(child: Text("7"), value: "7"),
    DropdownMenuItem(child: Text("8"), value: "8"),
    DropdownMenuItem(child: Text("9"), value: "9"),
    DropdownMenuItem(child: Text("10"), value: "10"),
  ];
  List<DropdownMenuItem<String>> childItems = [
    DropdownMenuItem(child: Text("1"), value: "1"),
    DropdownMenuItem(child: Text("2"), value: "2"),
    DropdownMenuItem(child: Text("3"), value: "3"),
    DropdownMenuItem(child: Text("4"), value: "4"),
    DropdownMenuItem(child: Text("5"), value: "5"),
    DropdownMenuItem(child: Text("6"), value: "6"),
    DropdownMenuItem(child: Text("7"), value: "7"),
    DropdownMenuItem(child: Text("8"), value: "8"),
    DropdownMenuItem(child: Text("9"), value: "9"),
    DropdownMenuItem(child: Text("10"), value: "10"),
  ];
  List<List<Map>> members = [
    [
      {"name": "", "age": "age", "nationality": "", "gender": ""}
    ]
  ];
  Razorpay razorpay = Razorpay();
  @override
  void initState() {
    super.initState();
    _date.text =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void handlerPaymentSuccess() {
    print("Pament success");
    // Toast.show("Pament success", context);
  }

  void handlerErrorFailure() {
    print("Pament error");
    // Toast.show("Pament error", context);
  }

  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlerExternalWallet() {
    print("External Wallet");
    // Toast.show("External Wallet", context);
  }

  Future<void> openCheckout() async {
    var options = {
      "key": "rzp_test_Ienn2nz5hJfAS1",
      "amount": num.parse(_amount.text) * 100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {"contact": "2323232323"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Book Ticket',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                letterSpacing: 0.0,
              ),
            ),
          elevation: 1.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                    child: Text(
                      'Select Date and Time',
                      style: TextStyle(
                        fontFamily: 'salsa',
                        fontSize: 25.0,
                        color: Color(0xff48CAE4)
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(17.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff48CAE4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: const Offset(
                            0,
                            3,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.calendar_today, color: Colors.white),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text(
                            "Choose Date",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Text(_date.text, style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(17.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff48CAE4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: const Offset(
                            0,
                            3,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 40.0),
                        Icon(Icons.account_balance, color: Colors.white),
                        SizedBox(width: 25.0),
                        Text(widget.monumentName,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      'Select Number of adult and child',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.all(17.0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xff48CAE4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(
                                0,
                                3,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 0.2,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              setState(() {
                                _adult.text = newValue!;
                              });
                            },
                            validator: (String? newValue) =>
                                newValue == null ? 'Adult' : null,
                            hint: Text('Adult',
                                style: TextStyle(color: Colors.white)),
                            // value: _division.text,
                            items: adultItems),
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.all(17.0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xff48CAE4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(
                                0,
                                3,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 0.2,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              setState(() {
                                _child.text = newValue!;
                              });
                            },
                            validator: (String? newValue) =>
                                newValue == null ? 'Child' : null,
                            hint: Text('Child',
                                style: TextStyle(color: Colors.white)),
                            // value: _division.text,
                            items: childItems),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xff48CAE4)),
                    onPressed: () {
                      setState(() {
                        showaddmembers = true;
                        total = int.parse(_adult.text) + int.parse(_child.text);
                        var totakdisplayamount =
                            int.parse(_adult.text) * widget.amountperadult +
                                int.parse(_child.text) * widget.amountperchild;
                        _amount.text = totakdisplayamount.toString();
                        for (int i = 1; i <= total; i++) {
                          itemsL.add(ItemLists(
                              id: i,
                              name: '',
                              nationality: '',
                              age: "",
                              gender: ""));
                        }
                      });
                    },
                    child: Text(
                      "Add member Details",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  showaddmembers
                      ? Scrollbar(
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemsL.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: ObjectKey(itemsL[index]),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 20),
                                          Text(
                                            "Member ",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          Text(
                                            "${itemsL[index].id}",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(15.0),
                                            padding: EdgeInsets.all(17.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.blueGrey[900],
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: const Offset(
                                                    0,
                                                    3,
                                                  ),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 0.2,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 30.0),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: TextFormField(
                                                        onChanged: (val) {
                                                          setState(() =>
                                                              itemsL[index]
                                                                  .name = val);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          labelText: 'Name',
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 30.0),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: TextFormField(
                                                        onChanged: (val) {
                                                          setState(() =>
                                                              itemsL[index]
                                                                  .age = val);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          labelText: 'Age',
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 30.0),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: TextFormField(
                                                        onChanged: (val) {
                                                          setState(() => itemsL[
                                                                      index]
                                                                  .nationality =
                                                              val = val);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          labelText:
                                                              'Nationality',
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 30.0),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: TextFormField(
                                                        onChanged: (val) {
                                                          setState(() =>
                                                              itemsL[index]
                                                                      .gender =
                                                                  val = val);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          labelText: 'Gender',
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      : Visibility(visible: false, child: Text("HELLO")),
                  showaddmembers
                      ? Container(
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.all(17.0),
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xff48CAE4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: const Offset(
                                  0,
                                  3,
                                ),
                                blurRadius: 5.0,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Total",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0)),
                              Text(_amount.text,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0)),
                            ],
                          ),
                        )
                      : Visibility(visible: false, child: Text("HELLO")),
                  showaddmembers
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff48CAE4)),
                          onPressed: () async {
                            await openCheckout();
                            List lst = [];
                            Map userdetail = {
                              "age": "",
                              "gender": "",
                              "name": "",
                              "nationality": ""
                            };
                            setState(() {
                              for (int i = 0; i < total; i++) {
                                userdetail = {
                                  "age": itemsL[i].age,
                                  "gender": itemsL[i].gender,
                                  "name": itemsL[i].name,
                                  "nationality": itemsL[i].nationality,
                                };
                                lst.add(userdetail);
                              }
                              time = DateFormat("hh:mm:ss a")
                                  .format(DateTime.now());
                              var ticketbooked = db
                                  .collection('tickets_booked')
                                  .doc(widget.uid)
                                  .set({
                                "date": _date.text,
                                "time": time,
                                "monument_name": widget.monumentName,
                                "members": lst,
                                "total_amount": _amount.text,
                                "location": widget.city + widget.state,
                                "uid": widget.uid,
                                "operatorID": widget.operatorID,
                                "mainPic": widget.mainPic
                              });
                            });
                          },
                          child: Text(
                            "Book Ticket",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : Visibility(visible: false, child: Text("Book Ticket")),
                  showaddmembers
                      ? ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          onPressed: () async {
                            await openCheckout();
                          },
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : Visibility(visible: false, child: Text("Pay")),
                ],
              ),
            )));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        _date.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
  }
}

class ItemLists {
  late int? id;
  late String? name;
  late String? nationality;
  late String? age;
  late String? gender;

  ItemLists({this.id, this.name, this.nationality, this.age, this.gender});
}
