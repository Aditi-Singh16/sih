import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sih/backend/firestore_data.dart';
import 'package:sih/backend/models/monument.dart';


class EditMonument extends StatefulWidget {
  const EditMonument({
    required this.monumentIndex,
    Key? key
  }) : super(key: key);
  final String monumentIndex;

  @override
  _EditMonumentState createState() => _EditMonumentState();
}

class _EditMonumentState extends State<EditMonument> {

  Monument? monument;
  FirestoreData firestoreData = FirestoreData();
  TextEditingController _controller = TextEditingController();
  TextEditingController _monumentNameController = TextEditingController();
  List<String> newGallery = [];
  String newDisplayPicture = '';
  final cloudinary = CloudinaryPublic('dvpg6kmsv', 'ticketbooking', cache: false);

  Future<CloudinaryResponse> uploadFileOnCloudinary({required String filePath, required CloudinaryResourceType resourceType}) async {
    CloudinaryResponse response;
    response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath, resourceType: resourceType),
      );
    return response;
  }

  Future selectFile() async {
    CloudinaryResponse response;
    var result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

    if (result != null) {
      for (PlatformFile file in result.files) {
        if (file.path != null) {
          response = await uploadFileOnCloudinary(
            filePath: file.path!,
            resourceType: CloudinaryResourceType.Auto,
          );
          if(result.files.length==1){
            setState(() {
              newDisplayPicture = response.secureUrl;
            });
          }else{
            setState(() {
              monument!.gallery.add(response.secureUrl);
            });
          }
        }
      }
    }

  }

  void getMonument()async{
    var res = await firestoreData.getMonument(widget.monumentIndex);
    setState(() {
      monument = res;
      _controller.text = res!.desc;
      _monumentNameController.text = res.monumentName;
    });
  }

  @override
  void initState() {
    getMonument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit monument details'
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: monument!=null?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        labelText:'Change Name',
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 5)
                        )
                    ),
                    controller: _monumentNameController,
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: ()async{
                        await selectFile();
                        Monument editedMonument = Monument(
                            desc: _controller.text,
                            gallery: newGallery,
                            mainPic: newDisplayPicture,
                            monumentName:_monumentNameController.text
                        );
                        await firestoreData.addOrUpdateMonument(editedMonument);
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Add Description',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5))),
                controller: _controller,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 5,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
              const Text(
                  'Edit Display Picture',
                  style:TextStyle(
                      fontSize: 22
                  )
              ),
            Container(
              width: width*0.9,
                height: height*0.2,
                decoration:BoxDecoration(
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
                      bottom:0.0,
                      top: 0.0,
                      child: Image.network(
                        newDisplayPicture.isNotEmpty?newDisplayPicture:monument!.mainPic,
                        width: width*0.9,
                        height: height*0.18,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                        top: 5.0,
                        right:5.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100]!.withOpacity(0.4),
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: (){
                              selectFile();
                            },
                          ),
                        )
                    ),
                  ],
                )
            ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              const Text(
                  'Edit Gallery',
                  style:TextStyle(
                      fontSize: 22
                  )
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing:10.0,
                  mainAxisSpacing:10.0,
                  crossAxisCount: 2,
                ),
                itemCount: monument!.gallery.length,
                itemBuilder: (context, index) {
                  return Container(
                      decoration:BoxDecoration(
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
                            bottom:0.0,
                            top: 0.0,
                            child: Image.network(
                              monument!.gallery[index],
                              width: width*0.45,
                              height: height*0.1,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 5.0,
                            right:5.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[100]!.withOpacity(0.4),
                              child: IconButton(
                                icon: const Icon(
                                    Icons.close_rounded,
                                  color: Colors.red,
                                ),
                                onPressed: (){
                                  setState(() {
                                    monument!.gallery.remove(monument!.gallery[index]);
                                  });
                                },
                              ),
                            )
                          ),
                        ],
                      )
                  );
                },
              ),
            ],
          ):
          Container(),
        ),
      )
    );
  }
}
