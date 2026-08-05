import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/services/apiconst.dart';
import '../../model/AddressModel.dart';
import '../../model/statecitymodel.dart';
import '../../widget/button.dart';
import '../../widget/textfieldscreen.dart';
import '../const.dart';
import '../localconst.dart';

// ignore: must_be_immutable
class StoreAddressAddPage extends StatefulWidget {
  StoreAddressAddPage({this.address});

  AddressModel? address;
  @override
  _StoreAddressAddPageState createState() => _StoreAddressAddPageState();
}

class _StoreAddressAddPageState extends State<StoreAddressAddPage> {
  final _formKey = GlobalKey<FormState>();
  //tring countryCode;
  //String cntryid;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _postCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _zoneController = TextEditingController();
  StateModel zoneName = new StateModel();
  CityModel cityName = new CityModel();

  // final _productIdController = TextEditingController();

  List<StateModel> stateList = [];
  List<CityModel> cityList = [];
  void initState() {
    _firstNameController.text = saveUser()?.data?.fullName ?? "";
    super.initState();
    // CountryList();
    // if (userItem.country == null && userItem.country.isEmpty)
    //   userItem.country = 'United Kingdom';

    // print(_countryController.text);
    this.loadState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  loadState() async {
    final response = await http
        .get(Common.getURL('store_stateList'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Cookie': Common.getCookie().toString()
      // "content-type": "application/x-www-form-urlencoded",
    });
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"].cast<Map<String, dynamic>>();
      print(parsed);

      setState(() {
        stateList = parsed
            .map<StateModel>((json) => StateModel.fromJson(json))
            .toList();
        print(stateList);
        StateModel selectState = new StateModel();
        selectState.stateName = '(Select)';
        selectState.id = 0;
        stateList.insert(0, selectState);

        // isLoading = false;
      });
      this.loadPaymentDefault();
    } else {
      throw Exception('Failed to load request');
    }
  }

  loadCityBlank() {
    CityModel selectCity = new CityModel();
    selectCity.cityName = '(Select)';
    selectCity.id = 0;
    cityList.insert(0, selectCity);

    cityName = cityList[0];
  }

  loadCity(stateId) async {
    print('aaa');
    final response = await http.get(
        Uri.parse('$mainlink/api/store_cityList/$stateId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        });
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"].cast<Map<String, dynamic>>();
      print(parsed);

      setState(() {
        cityList =
            parsed.map<CityModel>((json) => CityModel.fromJson(json)).toList();
        // isLoading = false;
        this.loadCityBlank();

        cityName = cityList[0];
      });
    } else {
      throw Exception('Failed to load request');
    }
  }

  loadPaymentDefault() async {
    if (this.widget.address != null) {
      AddressModel? address = this.widget.address;
      _firstNameController.text = address!.firstname;
      _lastNameController.text = address.lastname;
      _address1Controller.text = address.address1;
      _address2Controller.text = address.address2;
      _cityController.text = address.city;
      _postCodeController.text = address.postcode;
      _countryController.text = "IN";
      _zoneController.text = address.zone;
      zoneName = this
          .stateList
          .firstWhere((element) => element.stateName == address.zone);
      if (zoneName.id == 0)
        loadCityBlank();
      else
        await loadCity(zoneName.id);
      cityName = this
          .cityList
          .firstWhere((element) => element.cityName == address.city);
    } else {
      // _firstNameController.text = await Session.getPaymentFirstName();
      // _lastNameController.text = await Session.getPaymentLastName();
      // _address1Controller.text = await Session.getPaymentAddress1();
      // _address2Controller.text = await Session.getPaymentAddress2();
      // _cityController.text = await Session.getPaymentCity();
      // _postCodeController.text = await Session.getPaymentPostCode();
      // _countryController.text = "IN"; //await Session.getPaymentCountry();
      // _zoneController.text = await Session.getPaymentZone();
      // if (_zoneController.text.isNotEmpty)
      //   zoneName = this
      //       .stateList
      //       .firstWhere((element) => element.stateName == _zoneController.text);
      // else if (stateList.length > 0) zoneName = stateList.first;
      // if (zoneName.id == 0)
      //   loadCityBlank();
      // else
      //   await loadCity(zoneName.id);

      // if (_cityController.text.isNotEmpty)
      //   cityName = this
      //       .cityList
      //       .firstWhere((element) => element.cityName == _cityController.text);
      // else if (cityList.length > 0) cityName = cityList.first;
      _countryController.text = "IN";
      if (stateList.length > 0) zoneName = stateList.first;
      print(zoneName);
      loadCityBlank();
      await loadCity(zoneName.id);
      if (cityList.length > 0) cityName = cityList.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          (widget.address != null) ? "Edit Address" : "Add Address",
          style: TextStyle(color: Colors.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: kColorAppDefault,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(200))),
            child: InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.chevron_left_sharp,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
        actions: [],
      ),
      body: Builder(
        builder: (context) => Container(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text("First Name", style: Common.textFormFieldRegular),
                        SizedBox(height: 8),
                        Container(
                          height: 43,
                          child: NormalForm.plain(
                            '',
                            controller: _firstNameController,
                            textInputType: TextInputType.name,
                            textInputStyle: TextCapitalization.characters,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter firstname';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 14),
                        Text("Last Name", style: Common.textFormFieldRegular),
                        SizedBox(height: 8),
                        Container(
                          height: 43,
                          child: NormalForm.plain(
                            '',
                            controller: _lastNameController,
                            textInputType: TextInputType.name,
                            textInputStyle: TextCapitalization.characters,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter surname';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 14),
                        Text("State", style: Common.textFormFieldRegular),
                        SizedBox(height: 8),
                        Container(
                          height: 43,
                          decoration: ShapeDecoration(
                              shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(50.0),
                          )),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<StateModel>(
                                isExpanded: true,
                                hint: Text("  Select State"),
                                value: zoneName,
                                items: stateList
                                    .map<DropdownMenuItem<StateModel>>(
                                        (StateModel item) {
                                  return new DropdownMenuItem<StateModel>(
                                    value: item,
                                    child: new Text(
                                        "    " + item.stateName.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    zoneName = value!;
                                    // catID = value;
                                    // subcategoriesData = [];
                                    // subCategoriesList(catID);
                                    // _catLoading = true;
                                  });
                                  cityList = [];
                                  loadCity(value!.id);

                                  // int intStateId = 0;
                                  // List<StateModel> contain = stateList.where(
                                  //     (element) => element.stateName == value);
                                  // print(intStateId);
                                  // if (contain.isNotEmpty) {
                                  //   intStateId = contain[0].id;

                                  // }
                                }),
                          ),
                        ),
                        SizedBox(height: 14),
                        Text("City", style: Common.textFormFieldRegular),
                        SizedBox(height: 8),
                        Container(
                          height: 43,
                          decoration: ShapeDecoration(
                              shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(50.0),
                          )),
                          child: DropdownButtonHideUnderline(
                            child: new DropdownButton<CityModel>(
                                isExpanded: true,
                                hint: Text("  Select City"),
                                value: cityName,
                                items: cityList
                                    .map<DropdownMenuItem<CityModel>>((item) {
                                  return new DropdownMenuItem(
                                    value: item,
                                    child: new Text("    " + item.cityName!),
                                  );
                                }).toList(),
                                onChanged: (CityModel? value) {
                                  setState(() {
                                    cityName = value!;
                                    // catID = value;
                                    // subcategoriesData = [];
                                    // subCategoriesList(catID);
                                    // _catLoading = true;
                                  });
                                }),
                          ),
                        ),
                        SizedBox(height: 14),
                        Text("Village", style: Common.textFormFieldRegular),
                        SizedBox(height: 8),
                        Container(
                          height: 43,
                          child: NormalForm.plain(
                            'Village',
                            controller: _address2Controller,
                            textInputStyle: TextCapitalization.characters,
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Please enter some text';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(height: 14),
                        Text("Address", style: Common.textFormFieldRegular),
                        SizedBox(height: 8),
                        Container(
                          height: 43,
                          child: NormalForm.plain(
                            'Building, farm, House',
                            controller: _address1Controller,
                            textInputStyle: TextCapitalization.characters,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                          ),
                        ),

                        // SizedBox(height: 14),
                        // Text("City", style: Common.textFormFieldRegular),
                        // SizedBox(height: 8),
                        // Container(
                        //   height: 43,
                        //   child: NormalForm.plain(
                        //     '',
                        //     controller: _cityController,
                        //     validator: (value) {
                        //       if (value.isEmpty) {
                        //         return 'Please enter some text';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        SizedBox(height: 14),
                        Text("Pincode", style: Common.textFormFieldRegular),
                        SizedBox(height: 8),
                        Container(
                          height: 43,
                          child: NormalForm.plain(
                            'Pincode',
                            controller: _postCodeController,
                            textInputType: TextInputType.number,
                            maxLength: 6,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter pincode';
                              }
                              if (value.length != 6) {
                                return 'Please enter proper 6 digit pincode';
                              }
                              return null;
                            },
                          ),
                        ),

                        // Container(
                        //   height: 43,
                        //   child: NormalForm.plain(
                        //     '',
                        //     controller: _zoneController,
                        //     validator: (value) {
                        //       if (value.isEmpty) {
                        //         return 'Please enter some text';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),

                        SizedBox(height: 20),
                        Container(
                            alignment: Alignment.center,
                            child:
                                WideButton.bold(Lang.get("Submit"), () async {
                              _cityController.text = cityName.cityName!;
                              _zoneController.text = zoneName.stateName!;
                              if (_formKey.currentState!.validate()) {
                                Session.setPaymentAddress(
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _address1Controller.text,
                                    _address2Controller.text,
                                    _cityController.text,
                                    _postCodeController.text,
                                    _zoneController.text,
                                    _countryController.text);
                                await this._fetchAddress();

                                Navigator.pop(context, true);

                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //       return StoreCheckoutPage();
                                //     },
                                //   ),
                                // );
                              }
                            }, true)),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fetchAddress() async {
    _countryController.text = "IN";
    // EasyLoading.show(status: translate('Saving...'));
    print(Common.getURL("store_addressAdd"));
    String methodName = 'store_addressAdd';
    String id = '0';
    if (this.widget.address != null) {
      id = this.widget.address!.id.toString();
      methodName = 'store_addressUpdate';
    }
    final response = await http.post(Common.getURL(methodName),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'customer_id': saveUser()?.data?.id.toString() ?? "",
          'firstname': _firstNameController.text,
          'lastname': _lastNameController.text,
          'contact_number': '123456',
          'address_1': _address1Controller.text,
          'address_2': _address2Controller.text,
          'city': _cityController.text,
          'postcode': _postCodeController.text,
          'country': _countryController.text,
          'zone': _zoneController.text,
        }));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      EasyLoading.showToast(resBody["message"].toString());

      // final parsed = resBody["data"].cast<Map<String, dynamic>>();
      // print(parsed);

      // setState(() {});
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }
}
