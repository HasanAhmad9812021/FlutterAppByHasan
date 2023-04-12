import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ostad_flutter_batch_two/fcm_urils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FCMUtils().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BookListScreen(),
    );
  }
}

class BookListScreen extends StatefulWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Book> books = [];
  bool inProgress = false;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  XFile? pickedImage;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    //getBookList();
  }

  Future<void> getBookList() async {
    inProgress = true;
    setState(() {});
    books.clear();
    await firebaseFirestore.collection('books').get().then((documents) {
      for (var doc in documents.docs) {
        books.add(Book(doc.get('name'), doc.get('writter'), doc.get('year')));
      }
    });

    inProgress = false;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books Collection'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push((context),
                    MaterialPageRoute(builder: (context) => ImageScreen()));
              },
              icon: const Icon(Icons.image)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firebaseFirestore.collection('books').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.hasData) {
              books.clear();
              for (var doc in snapshot.data!.docs) {
                books.add(Book(doc.get('name'), doc.get('writter'), doc.get('year')));
              }
              return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(books[index].name),
                      subtitle: Text(books[index].authorName),
                      trailing: Text(books[index].year),
                    );
                  });
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          }),

      floatingActionButton: FloatingActionButton(onPressed: () async {

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Pick Image from'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('Gallery'),
                        leading: const Icon(Icons.image),
                        onTap: () async {
                          pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                          //log(pickedImage!.path);

                          if(pickedImage == null) {
                            return ;
                          }

                          String fileName =  DateTime.now().millisecondsSinceEpoch.toString();

                          try {
                            await firebaseStorage
                              .ref('images')
                              .child(fileName)
                              .putFile(File(pickedImage!.path))
                              .then((p0) {
                            log(p0.toString());
                          }).onError((error, stackTrace) {
                            log(error.toString());
                            log(stackTrace.toString());
                          });


                          log('Successfully Uploaded');
                          } catch (e) {
                            log('Upload failed. Try again!');
                          }
                        },
                      ),
                    ],
                  ),
                );
              });

      }),
    );
  }
}

class Book {
  final String name, authorName, year;

  Book(this.name, this.authorName, this.year);
}

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  List<Reference> storageReference = [];

  Future getImages() async {
    await firebaseStorage.ref('images').listAll().then((value) async {
      for (var valu in value.items) {
        storageReference = value.items;
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Screen'),
      ),
      body: ListView.builder(
          itemCount: storageReference.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                final url = await storageReference[index].getDownloadURL();
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => ImageViewer(url: url)));
              },
              title: Text(storageReference[index].name),
            );
          }),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final String url;
  const ImageViewer({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(url);
  }
}
