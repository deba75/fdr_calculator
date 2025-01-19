import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  double? interest;
  double? total;

  void calculation() {
    // Ensure inputs are valid before proceeding
    if (_controller1.text.isNotEmpty &&
        _controller2.text.isNotEmpty &&
        _controller3.text.isNotEmpty) {
      final depositAmount = double.parse(_controller1.text);
      final annualRate = double.parse(_controller2.text) / 100 / 12;
      final months = int.parse(_controller3.text);

      final calculatedInterest = depositAmount * annualRate * months;

      setState(() {
        interest = calculatedInterest;
        total = depositAmount + calculatedInterest;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.notes,
          size: 30,
          color: Colors.white,
        ),
        toolbarHeight: 30,
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.info,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fixed Deposit",
                      style: GoogleFonts.robotoMono(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Calculator",
                      style: GoogleFonts.robotoMono(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputForm(
                    title: "Deposit Amount :",
                    controller: _controller1,
                    hinttext: "e.g. 200000"),
                inputForm(
                    title: "Annual Interest Rate :",
                    controller: _controller2,
                    hinttext: "e.g. 3"),
                inputForm(
                    title: "Period(un month) :",
                    controller: _controller3,
                    hinttext: "e.g. 3"),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    calculation();
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "CALCULATE",
                        style: GoogleFonts.robotoMono(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                interest != null
                    ? Column(
                        children: [
                          Text(
                            "Result",
                            style: GoogleFonts.robotoMono(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              "Interest: ${interest!.toStringAsFixed(2)} Tk.",
                              style: GoogleFonts.robotoMono(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              "Total: ${total!.toStringAsFixed(2)} TK.",
                              style: GoogleFonts.robotoMono(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inputForm(
      {required String title,
      required TextEditingController controller,
      required String hinttext}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.robotoMono(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hinttext,
              ),
            )),
        SizedBox(height: 10),
      ],
    );
  }
}
