import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
//import 'dart:io';
import 'package:drop_example/Models/localization_model.dart';

class DropDownApp extends StatefulWidget {
  @override
  createState() => _DropDownAppState();
}

class _DropDownAppState extends State<DropDownApp> {
  List statesList = List();
  List provincesList = List();
  List tempList = List();
  String _state;
  String _province;

  Future<String> loadStatesProvincesFromFile() async {
    return await rootBundle.loadString('json/states.json');
  }

  Future<String> _populateDropdown() async {
    String getPlaces = await loadStatesProvincesFromFile();
    final jsonResponse = json.decode(getPlaces);

    Localization places = new Localization.fromJson(jsonResponse);

    setState(() {
      statesList = places.states;
      provincesList = places.provinces;
    });
  }

  @override
  void initState() {
    super.initState();
    this._populateDropdown();
  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dependable Dropdown Field'),
        ),
        body: Container(
          child: new Form(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 28),
              child: new Container(
                width: 350,
                child: Column(
                  children: <Widget>[
                    new TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.email),
                        hintText: 'Type your name',
                        labelText: 'Name',
                      ),
                    ),
                    new DropdownButton(
                      isExpanded: true,
                      icon: const Icon(Icons.add_location),
                      items: statesList.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.name),
                          value: item.id.toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _province = null;
                          _state = newVal;
                          tempList = provincesList
                              .where((x) =>
                                  x.stateId.toString() == (_state.toString()))
                              .toList();
                        });

                        // print(testingList.toString());
                      },
                      
                      value: _state,
                      hint: Text('Select a state'),
                    ),
                    new DropdownButton(
                      isExpanded: true,
                      icon: const Icon(Icons.gps_fixed),
                      items: tempList.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.name),
                          value: item.id.toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _province = newVal;
                        });
                      },
                      
                      value: _province,
                      hint: Text('Select a province'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
