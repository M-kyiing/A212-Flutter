import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor/views/cartscreen.dart';
import '../constant.dart';
import '../model/subject.dart';
import '../model/user.dart';

class SubjectPage extends StatefulWidget {
  final User user;
  const SubjectPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<Subject> subjectList = <Subject>[];
  late double screenHeight, screenWidth, resWidth;
  String search = "";
  String titlecenter = "Loading...";
  TextEditingController searchCont = TextEditingController();
  var numofpage, curpage = 1;
  var color, _tapPosition;
  int cart = 0;
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _loadCartQty();
    _loadSubject(1, search);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tutor - Subject'),
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('#457b9d'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
          TextButton.icon(
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => CartScreen(
                            user: widget.user,
                          )));
              _loadSubject(1, search);
              _loadCartQty();
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: Text(widget.user.cart.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: subjectList.isEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: [
                  Center(
                      child: Text(titlecenter,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ],
              ),
            )
          : Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(titlecenter = "Available Subjects",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: RefreshIndicator(
                key: refreshKey,
                onRefresh: () async {
                  _loadSubject(1, search);
                  _loadCartQty();
                },
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (1 / 1.3),
                    children: List.generate(subjectList.length, (index) {
                      return InkWell(
                        onTap: () => {_loadSubjectDetails(index)},
                        onTapDown: _storePosition,
                        child: Card(
                            color: HexColor('#dddddf'),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 6,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CachedNetworkImage(
                                      imageUrl: CONSTANTS.server +
                                          "/276984/mytutor/images/courses/" +
                                          subjectList[index].subID.toString() +
                                          '.png',
                                      fit: BoxFit.cover,
                                      width: resWidth,
                                      placeholder: (context, url) =>
                                          const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Center(
                                  heightFactor: 0.25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: FloatingActionButton.small(
                                          heroTag: null,
                                          onPressed: () {},
                                          backgroundColor: HexColor('#457b9d'),
                                          child: const FaIcon(
                                            FontAwesomeIcons.bookMedical,
                                            size: 25,
                                          ),
                                          elevation: 0.25,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: FloatingActionButton.small(
                                          heroTag: null,
                                          onPressed: () {},
                                          backgroundColor: HexColor('#457b9d'),
                                          child: const FaIcon(
                                            FontAwesomeIcons.heartCirclePlus,
                                            size: 20,
                                          ),
                                          elevation: 0.25,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: FloatingActionButton.small(
                                          heroTag: null,
                                          onPressed: () {
                                            _addtocartDialog(index);
                                          },
                                          backgroundColor: HexColor('#457b9d'),
                                          child: const FaIcon(
                                            FontAwesomeIcons.cartPlus,
                                            size: 20,
                                          ),
                                          elevation: 0.25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Flexible(
                                    flex: 4,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            subjectList[index]
                                                .subName
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text("RM " +
                                              double.parse(subjectList[index]
                                                      .subPrice
                                                      .toString())
                                                  .toStringAsFixed(2)),
                                          Text(subjectList[index]
                                                  .subSessions
                                                  .toString() +
                                              " sessions"),
                                          Text("Rating: " +
                                              subjectList[index]
                                                  .subRating
                                                  .toString()),
                                        ],
                                      ),
                                    ))
                              ],
                            )),
                      );
                    })),
              )),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.lightBlue;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () => {_loadSubject(index + 1, "")},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
    );
  }

  void _loadSubject(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/276984/mytutor/php/load_subject.php"),
        body: {
          'pageno': pageno.toString(),
          'search': _search,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);

      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);
        if (extractdata['subjects'] != null) {
          titlecenter = "Available Subjects";
          subjectList = <Subject>[];
          extractdata['subjects'].forEach((v) {
            subjectList.add(Subject.fromJson(v));
          });
        } else {
          titlecenter = "No Subject Available";
          subjectList.clear();
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Subject Available";
        subjectList.clear();
        setState(() {});
      }
    });
  }

  _loadSubjectDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Subject Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/276984/mytutor/images/courses/" +
                      subjectList[index].subID.toString() +
                      '.png',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  subjectList[index].subName.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Subject Description: \n" +
                      subjectList[index].subDesc.toString() +
                      "\n"),
                  Text("Tutor Incharge: " +
                      subjectList[index].tutorname.toString() +
                      "\n"),
                  Text("Subject Price: RM " +
                      double.parse(subjectList[index].subPrice.toString())
                          .toStringAsFixed(2) +
                      "\n"),
                  Text("Subject Sessions: " +
                      subjectList[index].subSessions.toString() +
                      " sessions"),
                ])
              ],
            )),
            actions: [
              TextButton(
                child: const Text(
                  "Close",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _loadSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search ",
                ),
                content: SizedBox(
                  //height: screenHeight / 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchCont,
                        decoration: InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      search = searchCont.text;
                      Navigator.of(context).pop();
                      _loadSubject(1, search);
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }

  void _loadCartQty() {
    http.post(
        Uri.parse(CONSTANTS.server + "/276984/mytutor/php/load_mycart.php"),
        body: {
          'email': widget.user.email.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        print(jsondata['data']['carttotal'].toString());
        setState(() {
          widget.user.cart = jsondata['data']['carttotal'].toString();
        });
      }
    });
  }

  void _addtocartDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Add to Cart",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addToCart(index);
                _loadCartQty();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addToCart(int index) {
    http.post(
        Uri.parse(CONSTANTS.server + "/276984/mytutor/php/insert_cart.php"),
        body: {
          'email': widget.user.email.toString(),
          'subID': subjectList[index].subID.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        print(jsondata['data']['carttotal'].toString());
        setState(() {
          widget.user.cart = jsondata['data']['carttotal'].toString();
        });
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
}
