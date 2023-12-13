import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LabScreen extends StatefulWidget {
  const LabScreen({super.key});

  @override
  State<LabScreen> createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen> {
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 145, 182, 216),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.blue,
        title: Text(
          'Logo name',
          style: TextStyle(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: const Text('Upload Image'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _selectedImagePath != null
              ? Image.file(
                  File(_selectedImagePath!),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.purple)),
                        onPressed: () {},
                        child: Text(
                          'Lap Analysis',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.purple)),
                        onPressed: () {},
                        child: Text(
                          'Lap Recomedations',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Back')),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber)),
                        onPressed: () {},
                        child: Text(
                          'LogOut',
                        )),
                  ],
                ),
              ),
            ),
          )

          // Expanded(
          //   child: GridView.builder(
          //       itemCount: _selectedImagePath!.length,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 3),
          //       itemBuilder: (context, index) {
          //         return Image.file(
          //           File(_selectedImagePath![index]),
          //           width: 100,
          //           height: 100,
          //           fit: BoxFit.cover,
          //         );
          //       }),
          // )
        ],
      ),
    );
  }
}
