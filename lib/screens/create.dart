import 'package:flutter/material.dart';

class CustomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        // color: Colors.lightBlue, // Set your desired background color here
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Text(
                  'Hello',
                  style: TextStyle(fontSize: 40, color: Colors.white, fontFamily: 'Poppins'),
                ),
              ),
              Text(
                'Start Your Beautiful Day',
                style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 400), // Add spacing between the texts and buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/todo');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(18.0),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      child: Text( 'Add Task',style: TextStyle(fontFamily: 'Poppins',fontSize: 17)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Add spacing between the buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(18.0),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      child: Text( 'View All',style: TextStyle(fontFamily: 'Poppins',fontSize: 17)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CustomScreen(),
    debugShowCheckedModeBanner: false, // Hide debug banner
  ));
}
