import 'package:flutter/material.dart';

import 'database.dart';

void main() {
  runApp(TransactionApp());
}

class TransactionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransactionScreen(),
    );
  }
}

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<TransactionDetails> transactions = [];
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    List<TransactionDetails> fetchedTransactions = await databaseHelper.fetchTransactions();
    setState(() {
      transactions = fetchedTransactions;
    });
  }

  Future<void> insertSampleTransaction() async {
    // Example of inserting a transaction
    TransactionDetails transaction = TransactionDetails(
      date: '2024-07-08',
      mobileNumber: '1234567890',
      package: 'Data Package',
      txid: 'TX1234567890',
    );
    
    int insertedId = await databaseHelper.insertTransaction(transaction);
    print('Inserted transaction ID: $insertedId');
    fetchTransactions(); // Refresh list after insertion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Balance',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF1569C7),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: image,
              child: Image.network(
                'http://10.0.1.165/mtimages.gif',
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          'http://10.0.6.101/Prefix_mobile.png',
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          fit: FlexFit.loose,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter mobile number',
                              labelStyle: TextStyle(
                                color: Color(0xFF1569C7),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            // Replace with appropriate form context ID
                            // id: 'mobile_number',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Image.network(
                            'http://10.0.1.165/Prefix_date.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: GestureDetector(
                            onTap: () {
                              _selectFromDate(context);
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: fromDateController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  labelText: 'From Date',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF1569C7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                // Replace with appropriate form context ID
                                // id: 'from_date',
                                // width: 150,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Image.network(
                            'http://10.0.1.165/Prefix_date.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: GestureDetector(
                            onTap: () {
                              _selectToDate(context);
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: toDateController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  labelText: 'To Date',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF1569C7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                // Replace with appropriate form context ID
                                // id: 'to_date',
                                // width: 150,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // Replace with appropriate function for PIN submission
                        pin('form_context');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'Proceed',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '------------Recent Transactions------------',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        TransactionDetails transaction = transactions[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${transaction.id}'),
                            SizedBox(height: 5),
                            Text('Date: ${transaction.date}'),
                            SizedBox(height: 5),
                            Text('Mobile Number: ${transaction.mobileNumber}'),
                            SizedBox(height: 5),
                            Text('Package: ${transaction.package}'),
                            SizedBox(height: 5),
                            Text('TXID: ${transaction.txid}'),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showImageDialog(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Image.network(
                                      'http://10.0.1.165/success.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void image() {
    // Implement your image handling logic here
  }

  void pin(String context) {
    // Implement your PIN submission logic here
  }

  void dummyFunction() {
    // Implement your dummy function logic here
  }

  void SSdummyFunction() {
    // Implement your dummy function logic here
  }

  Future<void> _selectFromDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        fromDateController.text = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        toDateController.text = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      });
    }
  }

  Future<void> _showImageDialog(BuildContext context) async {
    // Implement your dialog logic here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Image Button Clicked'),
          content: Text('This is the dialog content.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
