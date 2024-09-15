import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api.dart';
import 'SituationWeb.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  @override
  State<StatefulWidget> createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  Future Addtrip() async {

    print('wait');
    try {

      //SharedPreferences preferences = await SharedPreferences.getInstance();
      // var Token = preferences.getString('access_token');
      var response = await http.post(
        Uri.parse('http://192.168.43.93:3000/api/v1/trips'),
        body: json.encode({
          'name': NameController.text,
          'slug': SlugController.text,
          'destination': destinationController.text,
          'beginCenter': BeginController.text,
          'flightDate': FlightDateController.text,
          'theNumberOfSeats': NOFController.text,
          'AvailableSeats': AvailabelSeatsController.text,
          'SoldSeats': SoldSeatsController.text,
          'ticketPrice': TiketPriceController.text,
          'description': DescriptionController.text,
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      print('response is ${response.body}');
      print('response is ${response.statusCode}');
      if (response.statusCode == 201) {
        print(response.body);
        print('siiiiiii');
      } else {}
    } catch (Exception) {
      print(Exception);
    }
  }

  final SlugController = TextEditingController();
  final NameController = TextEditingController();
  final destinationController = TextEditingController();
  final BeginController = TextEditingController();
  final FlightDateController = TextEditingController();
  final NOFController = TextEditingController();
  final AvailabelSeatsController = TextEditingController();
  final SoldSeatsController = TextEditingController();
  final TiketPriceController = TextEditingController();
  final DescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(0, 186, 175, 1),
                      Color.fromRGBO(110, 190, 170, 1),
                      Colors.white,
                    ]),
              ),
              child: const Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 300, right: 15),
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: 0, left: 70, right: 20),
              color: Colors.white30,
              child: Column(
                children: [
                  const SizedBox(height: 0),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 200),
                        child: Text(
                          "Adding Drugs",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                              color: Color.fromRGBO(0, 186, 175, 1)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 170),
                        child: Text(
                          'add your medicine to the Storehouse',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 300))
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 0, right: 25),
                    child: Column(
                      children: [
                        buildTextFormField(NameController, 'Name'),
                        buildTextFormField(SlugController, 'Slug'),
                        const SizedBox(height: 1),
                        buildTextFormField(
                            destinationController, 'Destination'),
                        const SizedBox(height: 1),
                        buildTextFormField(BeginController, 'Begin Centerd'),
                        const SizedBox(height: 1),
                        buildTextFormField(FlightDateController, 'Flight date'),
                        const SizedBox(height: 1),
                        buildTextFormField(NOFController, 'Number Of Seats'),
                        const SizedBox(height: 1),
                        buildTextFormField(
                            AvailabelSeatsController, 'Available Seats'),
                        const SizedBox(height: 1),
                        buildTextFormField(SoldSeatsController, 'Sold Seats'),
                        const SizedBox(height: 1),
                        buildTextFormField(TiketPriceController, 'Tiket Price'),
                        const SizedBox(height: 10),
                        buildTextFormField(DescriptionController, 'Desciption'),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              height: 50,
                              padding: const EdgeInsets.only(
                                  right: 100, top: 20, bottom: 5),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromRGBO(0, 186, 175, 1)),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))))),
                                onPressed: () async {
                                  await Addtrip();
                                },
                                child: const Text(
                                  'Add',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 200),
                                child: TextButton(
                                    onPressed: () {
                                    //  Get.to(const SituationWeb());
                                    },
                                    child: const Text(
                                      'orders',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color:
                                              Color.fromRGBO(0, 186, 175, 1)),
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  buildTextFormField(controller, String labeltext) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: labeltext,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          filled: true,
          fillColor: Colors.white),
    );
  }
}
