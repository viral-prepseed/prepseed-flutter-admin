import 'package:flutter/material.dart';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:prepseed/views/login/company_signIn_signUp.dart';

class prepSeed_login extends StatefulWidget {
  const prepSeed_login({Key? key}) : super(key: key);

  @override
  State<prepSeed_login> createState() => _prepSeed_loginState();
}

class _prepSeed_loginState extends State<prepSeed_login> {
  final _prepSeed_login = GlobalKey<FormState>();
  String institutename = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Column(
          children: [
            Image.asset('assets/images/logo.jpg'),
            SizedBox(height: 45,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _prepSeed_login,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownSearch<String>(
                    showSearchBox: true,
                    /*popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      disabledItemFn: (String s) => s.startsWith('I'),
                    ),*/
                    items: const ["Institute 1", "Institute 2", "Institute 3", 'Institute 4'],
                    dropdownSearchDecoration: const InputDecoration(
                      labelText: "Select your Institute",
                      // hintText: "country in menu mode",
                    ),
                    onChanged: print,
                    validator: (String? item) {
                      if (item == null){

                        return "Please select any one before proceeding further.";
                      }
                      else{
                        setState(() {
                          institutename = item;
                        });
                        return null;
                      }
                    },
                    // selectedItem: "Brazil",
                  ),
                ),
              ),
            ),
            SizedBox(height: 70,),
            ElevatedButton(onPressed: (){
                if (_prepSeed_login.currentState!.validate()) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signIn_signUp(clientname: institutename,)));
                }else{
                  print('oops..');
                  return null;
                }
            },
                child: Text('Next'))
          ],
        ),
      ),
    );
  }
}
