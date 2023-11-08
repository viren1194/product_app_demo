import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List<String> values = ['hi', 'hello'];
  String selectedValue = '';
  // String previousSelectedValue = '';

  // void toggleValue(String value) {
  //   if (selectedValue == value) {
  //     setState(() {
  //       selectedValue = '';
  //       previousSelectedValue = '';
  //     });
  //     Get.back();
  //   } else {
  //     setState(() {
  //       previousSelectedValue = selectedValue;
  //       selectedValue = value;
  //     });
  //     print(selectedValue);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: () {
            Get.bottomSheet(
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: values.length + 1, // Add 1 for the "All" option
                  itemBuilder: (context, index) {
                    if (index == values.length) {
                      // Add a special "All" radio tile
                      return RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: Colors.blue,
                        title: Text('All'),
                        subtitle: const Text('data'),
                        value: 'null',
                        groupValue: selectedValue,
                        onChanged: (value) {
                          // toggleValue(value!);
                          setState(() {
                            selectedValue = value!;
                            print(selectedValue);
                            Get.back();
                          });
                        },
                      );
                    } else {
                      // Regular radio tiles from the values list
                      final value = values[index];
                      return RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: Colors.blue,
                        title: Text(value),
                        subtitle: const Text('data'),
                        value: value,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                            print(selectedValue);
                            Get.back();
                          });
                        },
                      );
                    }
                  },
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              backgroundColor: Colors.orange,
            );
          },
          child: const Text("Button"),
        ),
      ),
    );
  }
}
