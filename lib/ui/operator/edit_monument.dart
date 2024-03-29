// ignore_for_file: prefer_final_fields

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sih/backend/firestore_data.dart';
import 'package:sih/backend/models/monument.dart';
import 'package:sih/prefs/sharedPrefs.dart';

class EditMonument extends StatefulWidget {
  const EditMonument({Key? key}) : super(key: key);

  @override
  _EditMonumentState createState() => _EditMonumentState();
}

class _EditMonumentState extends State<EditMonument> {
  Monument? monument;
  FirestoreData firestoreData = FirestoreData();
  TextEditingController _controller = TextEditingController();
  TextEditingController _monumentNameController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _foreignController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _indianAdultController = TextEditingController();
  TextEditingController _indianChildController = TextEditingController();

  TextEditingController _latController = TextEditingController();
  TextEditingController _longController = TextEditingController();

  List<String> newGallery = [];
  String newDisplayPicture = '';
  final cloudinary =
      CloudinaryPublic('dvpg6kmsv', 'ticketbooking', cache: false);

  Future<String> uploadFileOnCloudinary(
      {required String? filePath,
      required CloudinaryResourceType resourceType}) async {
    CloudinaryResponse response;
    try {
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath!, resourceType: resourceType),
      );
      print(response);
      return response.secureUrl;
    } catch (e) {
      return e.toString();
    }
  }

  Future selectFile(String type) async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result != null) {
      for (PlatformFile file in result.files) {
        if (file.path != null) {
          String responseUrl = await uploadFileOnCloudinary(
            filePath: file.path,
            resourceType: CloudinaryResourceType.Auto,
          );
          if (type == 'DP') {
            setState(() {
              newDisplayPicture = responseUrl;
            });
          } else {
            setState(() {
              monument!.gallery.add(responseUrl);
            });
          }
        }
      }
    }
  }

  void getMon() async {
    HelperFunctions _helperFunctions = HelperFunctions();
    var opid = await _helperFunctions.readUserIdPref();
    Monument? res = await firestoreData.getMonument(opid);
    print(res);
    setState(() {
      monument = res;
      _controller.text = res!.desc;
      _monumentNameController.text = res.monumentName;
      _categoryController.text = res.category;
      _cityController.text = res.city;
      _endController.text = res.end;
      _stateController.text = res.state;
      _foreignController.text = res.foreigner;
      _indianAdultController.text = res.indian['adult'].toString();
      _indianChildController.text = res.indian['kid'].toString();
      _longController.text = res.long.toString();
      _latController.text = res.lat.toString();
      _startController.text = res.start;
    });
  }

  @override
  void initState() {
    getMon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit monument details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: monument != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.4,
                            child: TextField(
                              decoration: const InputDecoration(
                                  labelText: 'Change Name',
                                  border: OutlineInputBorder(),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 5))),
                              controller: _monumentNameController,
                            ),
                          ),
                          CircleAvatar(
                            child: IconButton(
                              icon: const Icon(Icons.save),
                              onPressed: () async {
                                var monId = await HelperFunctions()
                                    .readMonumentIdPref();
                                print("monId" + monId);
                                monument!.gallery.addAll(newGallery);
                                Monument editedMonument = Monument(
                                    desc: _controller.text,
                                    gallery: monument!.gallery,
                                    mainPic: newDisplayPicture,
                                    monumentName: _monumentNameController.text,
                                    city: _cityController.text,
                                    state: _stateController.text,
                                    lat: double.parse(_latController.text),
                                    long: double.parse(_latController.text),
                                    rating: "4.5",
                                    start: _stateController.text,
                                    end: _endController.text,
                                    operatorID: await HelperFunctions()
                                        .readUserIdPref(),
                                    category: _categoryController.text,
                                    foreigner: _foreignController.text,
                                    indian: {
                                      "adult": _indianAdultController.text,
                                      "kid": _indianChildController.text
                                    });
                                await firestoreData.addOrUpdateMonument(
                                  editedMonument,monId
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: 'State',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                            controller: _stateController,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: width * 0.4,
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: 'City',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                            controller: _cityController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: 'Opening time',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                            controller: _startController,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: width * 0.4,
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: 'Closing time',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                            controller: _endController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: 'Longitude',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                            controller: _longController,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: width * 0.45,
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: 'Latitude',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                            controller: _latController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Entry Fee',
                        style: TextStyle(color: Color(0xFF0077B6)),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.9,
                      child: TextField(
                        decoration: const InputDecoration(
                            labelText: 'Foreigners',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5))),
                        controller: _foreignController,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: 'Indians-Adults',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                            controller: _indianAdultController,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: width * 0.4,
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: 'Indians-Children',
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5))),
                            controller: _indianChildController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: width * 0.95,
                      child: TextField(
                        decoration: const InputDecoration(
                            labelText: 'Add Description',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5))),
                        controller: _controller,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 5,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    const Text(
                      'Edit Display Picture',
                      style: TextStyle(color: Color(0xFF0077B6), fontSize: 22),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                        width: width * 0.9,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0.0,
                              top: 0.0,
                              child: Image.network(
                                newDisplayPicture.isNotEmpty
                                    ? newDisplayPicture
                                    : monument!.mainPic,
                                width: width * 0.9,
                                height: height * 0.18,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                                top: 5.0,
                                right: 5.0,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Colors.grey[100]!.withOpacity(0.4),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      selectFile('DP');
                                    },
                                  ),
                                )),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Edit Gallery',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF0077B6),
                            )),
                        CircleAvatar(
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            onPressed: () async {
                              await selectFile('Gallery');
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        crossAxisCount: 2,
                      ),
                      itemCount: monument!.gallery.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0.0,
                                  top: 0.0,
                                  child: Image.network(
                                    monument!.gallery[index],
                                    width: width * 0.45,
                                    height: height * 0.1,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                    top: 5.0,
                                    right: 5.0,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.grey[100]!.withOpacity(0.4),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            monument!.gallery.remove(
                                                monument!.gallery[index]);
                                          });
                                        },
                                      ),
                                    )),
                              ],
                            ));
                      },
                    ),
                  ],
                )
              : Container(child: Text('error')),
        ),
      ),
      // bottomNavigationBar: OperatorBottomNavBar(),
    );
  }
}
