import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:itube/app/screens/home.dart';

class CSC_Picker extends StatefulWidget {
  const CSC_Picker({super.key});

  @override
  State<CSC_Picker> createState() => _CSC_PickerState();
}
 String? selectedCountry;
  String? selectedCity;
class _CSC_PickerState extends State<CSC_Picker>{
 @override
  void initState() {
    setState(() {
      
    });
    super.initState();
  }
  @override
  void dispose() {
    setState(() {
      
    });
    super.dispose();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade800,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: Card(
              color: const Color.fromARGB(255, 209, 141, 141),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), 
              ),
              shadowColor: Colors.black,
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CSCPicker(
                  layout: Layout.vertical,
                  flagState: CountryFlag.DISABLE,
                  onCountryChanged: (country){
                    debugPrint(country);
                    setState(() {
                      selectedCountry=country;
                    });
                  },
                  onStateChanged: (state){
                    debugPrint(state);
                  },
                  onCityChanged: (city){
                    debugPrint(city);
                    setState(() {
                      selectedCity = city;
                    });
                  },
                
                  countrySearchPlaceholder: "Country",
                  stateSearchPlaceholder: "State",
                  citySearchPlaceholder: "City",

                  countryDropdownLabel: "Select Country",
                  stateDropdownLabel: "Select State",
                  cityDropdownLabel: "Select City",
                  dropdownDialogRadius: 12.0,
                  searchBarRadius: 30.0,
                  dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.red,
                      border:
                      Border.all(color: const Color.fromARGB(255, 121, 116, 116), width: 2)),

                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).colorScheme.background,
                      border:
                      Border.all(color: Colors.grey.shade600, width: 2)),
                 
                  selectedItemStyle: TextStyle(

                    fontSize: 14,
                  ),

                 
                  dropdownHeadingStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold),

                  dropdownItemStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            setState(() {
             locationCity=selectedCity!;
             locationCountry=selectedCountry!;
            });
            
          }, child: Text("Confirm")),
          Text('to ${selectedCity??""}, ${selectedCountry??""}'),
          Text('from $locationCity, $locationCountry')
        ],
      ),
    );
  }
}