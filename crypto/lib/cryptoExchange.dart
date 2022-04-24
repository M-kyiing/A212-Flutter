import 'package:crypto/cryp_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

void main() => runApp(const CryptoApp());

class CryptoApp extends StatelessWidget {
  const CryptoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitCoin Crypto',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bitcoin Crypto Exchange App'),
        ),
        body: const CrytoExchangePage(),
      ),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}

class CrytoExchangePage extends StatefulWidget {
  const CrytoExchangePage({Key? key}) : super(key: key);

  @override
  State<CrytoExchangePage> createState() => _CrytoExchangePageState();
}

class _CrytoExchangePageState extends State<CrytoExchangePage> {
  TextEditingController crypInput = TextEditingController();

  String selectC = "btc";
  String descV = "";

  var unit = "", name = "", type = "", cVal = 0.0, crypIn = 0.0, exResult = 0.0;

  Coinpage getCryp =
      Coinpage("Not Available", "Not Available", 0.0, "Not Available");
  List<String> cNameList = [
    "btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
    "lkr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "twd",
    "try",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "xau",
    "bits",
    "sats",
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Text(
          'Bitcoin Cryptocurrency Exchange',
          textAlign: TextAlign.start,
          style:
              TextStyle(height: 1.5, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Image.asset("assets/images/cryp.jpg"),
        ),
        //const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 260,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  labelText: 'Enter value to exchange',
                ),
                controller: crypInput,
              ),
            ),
            SizedBox(
              width: 75,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  isExpanded: true,
                  itemHeight: 50,
                  value: selectC,
                  onChanged: (newValue) {
                    setState(() {
                      selectC = newValue.toString();
                    });
                  },
                  items: cNameList.map((selectC) {
                    return DropdownMenuItem(
                      child: Text(
                        selectC,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                      value: selectC,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ElevatedButton(
            onPressed: _loadCoin,
            style: ElevatedButton.styleFrom(
                primary: Colors.indigo[200], // background
                onPrimary: Colors.black, // foreground
                shadowColor: Colors.grey,
                elevation: 10),
            child: const Text("Exchange Now",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
        const SizedBox(height: 15),
        Expanded(
          child: CryptoList(
            getCryp: getCryp,
          ),
        ),
      ],
    ));
  }

  Future<void> _loadCoin() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();
    var url = Uri.parse("https://api.coingecko.com/api/v3/exchange_rates");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      unit = parsedData['rates'][selectC]['unit'];
      name = parsedData['rates'][selectC]['name'];
      type = parsedData['rates'][selectC]['type'];
      cVal = parsedData['rates'][selectC]['value'];

      crypIn = double.parse(crypInput.text);
      setState(() {
        exResult = cVal * crypIn;
      });
    }
    getCryp = Coinpage(name, unit, exResult, type);
    progressDialog.dismiss();
  }
}

class CryptoList extends StatefulWidget {
  final Coinpage getCryp;
  const CryptoList({Key? key, required this.getCryp}) : super(key: key);

  @override
  _CryptoListState createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(10), children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo[200],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6,
                        offset: Offset(4, 9), // Shadow position
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("Cryptocurrency",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.currency_bitcoin_rounded,
                        size: 62,
                      ),
                      Text("Bitcoin",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Icon(Icons.double_arrow_rounded, size: 54),
          Flexible(
            child: Column(
              children: [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo[200],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 6,
                          offset: Offset(4, 9), // Shadow position
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Cryptocurrency",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        const Icon(
                          Icons.currency_bitcoin_rounded,
                          size: 62,
                        ),
                        Text(widget.getCryp.n,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 18),
      Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo[200],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 6, offset: Offset(4, 8)),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.currency_exchange,
                  size: 35,
                ),
                const Text("Exchange Value",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                Text(widget.getCryp.val.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo[200],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 6, offset: Offset(4, 8)),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.money_rounded,
                  size: 50,
                ),
                const Text("Cryptocurrency Unit",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                Text(widget.getCryp.uni,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo[200],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 6, offset: Offset(4, 8)),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.attach_money_rounded,
                  size: 50,
                ),
                const Text("Cryptocurrency Type",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                Text(widget.getCryp.ty,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
