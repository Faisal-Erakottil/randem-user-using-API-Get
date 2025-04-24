// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:randemuser/model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: non_constant_identifier_names
  Future<Randomuser> FetchData() async {
    print("button pressed");
    const url = "https://randomuser.me/api/";
    print(url);

    final responce = await http.get(Uri.parse(url));

    if (responce.statusCode == 200) {
      log(responce.body);
      return randomuserFromJson(responce.body);
    } else {
      log(responce.body);
      throw Exception("No Data found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Randem User",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
        future: FetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error:${snapshot.hasError}"));
          } else if (snapshot.hasData) {
            final data = snapshot.data?.results ?? [];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      // Image(
                      //   image: NetworkImage(data.first.picture.large),
                      // ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Name: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(data.first.name.toString()),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Email: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(data.first.email),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Location: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(data.first.location.toString()),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                /////////////////////////////
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      FetchData();
                    });
                  },
                  child: const Text("Next"),
                ),
                /////////////////////////////
              ],
            );
          } else {
            return const Center(
              child: Text("No Data Available"),
            );
          }
        },
      ),
    );
  }
}
