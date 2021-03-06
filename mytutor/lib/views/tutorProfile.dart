import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';
import '../model/tutor.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  List<Tutor> tutorList = <Tutor>[];
  late double screenHeight, screenWidth, resWidth;
  String search = "";
  String titlecenter = "Loading...";
  var numofpage, curpage = 1;
  var color, _tapPosition;
  TextEditingController searchCont = TextEditingController();
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _loadTutors(1, search);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Tutor - Tutor Profile'),
        backgroundColor: HexColor('#457b9d'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          )
        ],
      ),
      body: tutorList.isEmpty
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
                child: Text(titlecenter = "Available Tutors",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  child: RefreshIndicator(
                      key: refreshKey,
                      onRefresh: () async {
                        _loadTutors(1, search);
                      },
                      child: ListView(
                          // crossAxisCount: 1,
                          // childAspectRatio: (1 / 0.6),
                          children: List.generate(tutorList.length, (index) {
                        return InkWell(
                          onTap: () => {_loadTutorDetails(index)},
                          onTapDown: _storePosition,
                          child: Card(
                              margin: EdgeInsets.all(7),
                              color: HexColor('#dddddf'),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 120,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: CONSTANTS.server +
                                            "/276984/mytutor/images/tutors/" +
                                            tutorList[index]
                                                .tutorID
                                                .toString() +
                                            '.jpg',
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                        // width: resWidth,
                                        placeholder: (context, url) =>
                                            const LinearProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          tutorList[index].tutorName.toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                        ),
                                        Text(
                                          "\nContact Information: \n" +
                                              tutorList[index]
                                                  .tutorEmail
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(tutorList[index]
                                                .tutorPhone
                                                .toString() +
                                            "\n")
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              )),
                        );
                      })))),
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
                          onPressed: () => {_loadTutors(index + 1, "")},
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

  void _loadTutors(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/276984/mytutor/php/load_tutor.php"),
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
        if (extractdata['tutors'] != null) {
          titlecenter = "Available Tutors";
          tutorList = <Tutor>[];
          extractdata['tutors'].forEach((v) {
            tutorList.add(Tutor.fromJson(v));
          });
        } else {
          titlecenter = "No Tutor Available";
          tutorList.clear();
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Tutor Available";
        tutorList.clear();
        setState(() {});
      }
    });
  }

  _loadTutorDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Tutor Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/276984/mytutor/images/tutors/" +
                      tutorList[index].tutorID.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  tutorList[index].tutorName.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("\nTutor Description: \n" +
                      tutorList[index].tutorDesc.toString() +
                      "\n"),
                  Text("Incharge Courses: \n" +
                      tutorList[index].subjectName.toString() +
                      "\n"),
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
    searchCont.text = "";
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
                            labelText: 'Enter Tutor Name',
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
                      _loadTutors(1, search);
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }
}
