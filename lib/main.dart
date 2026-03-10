import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                            child: Image.network(
                              'https://img.freepik.com/free-photo/portrait-young-handsome-man-jean-shirt-smiling-with-crossed-arms_176420-12083.jpg?semt=ais_rp_50_assets&w=740&q=80',
                              height: 50,
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text('john')
                        ],
                      ),
                    );
                  } 
                ),
              )
            ]
          ),
        )
      ),
    );
    
  }
}