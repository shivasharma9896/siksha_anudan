import 'dart:io';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'constants.dart';


class Registration_Student extends StatefulWidget {
  const Registration_Student({Key? key}) : super(key: key);

  @override
  State<Registration_Student> createState() => _Registration_Student();
}

class _Registration_Student extends State<Registration_Student> {
  int _activeStepIndex = 0;
  TextEditingController name=TextEditingController();
  TextEditingController fname=TextEditingController();
  TextEditingController mname=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController pincode=TextEditingController();
  //TextEditingController _dayvalue=TextEditingController();
  //TextEditingController _monvalue=TextEditingController();
  //TextEditingController _yearvalue=TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  String? _dayvalue = '';
  String? _monvalue = '';
  String? _yearvalue = '';
  //String _valueToValidate3 = '';
  String _valueSaved3 = '';
  TextEditingController highschoolcollegename=TextEditingController();
  TextEditingController highschoolboard=TextEditingController();
  TextEditingController highschoolpercent=TextEditingController();
  TextEditingController intermediatecollegename=TextEditingController();
  TextEditingController intermediateboard=TextEditingController();
  TextEditingController intermediatepercent=TextEditingController();
  File? _photo;
  File? _signature;
  File? _sop;
  Future getPhoto(ImageSource source) async{
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = File(image.path);

      setState(() {
        this._photo = imagePermanent;
      });
    }
    on PlatformException catch(e){
      print('Failed to pick image:$e');
    }
  }
  Future getSignature(ImageSource source) async{
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = File(image.path);

      setState(() {
        this._signature = imagePermanent;
      });
    }
    on PlatformException catch(e){
      print('Failed to pick image:$e');
    }
  }
  Future getsop(ImageSource source) async{
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = File(image.path);

      setState(() {
        this._sop = imagePermanent;
      });
    }
    on PlatformException catch(e){
      print('Failed to pick image:$e');
    }
  }
  Future<File> saveFilePermanentely(String imagePath) async{
    final directory =await getApplicationDocumentsDirectory();
    final name=basename(imagePath);
    final image=File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }
  List<Step> stepList() => [
        Step(
            state:_activeStepIndex<=0?StepState.editing : StepState.complete,
            isActive:_activeStepIndex>=0,
            title: const Text('Personal Information'),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: fname,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Father Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: mname,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mother Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: address,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: pincode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pincode',
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    color: Colors.white,
                    child:const Text("Date of Birth",style: TextStyle(
                      color: Colors.grey,
                    ),),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownDatePicker(
                    boxDecoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ), // optional
                    isDropdownHideUnderline: true, // optional
                    isFormValidator: true, // optional
                    startYear: 1950, // optional
                    endYear: 2020, // optional
                    width: 10, // optional
                   // onChangedDay: (_dayvalue) => print('onChangedDay: $_dayvalue'),
                   //  onChangedMonth: (_monvalue) => print('onChangedMonth: $_monvalue'),
                   //  onChangedYear: (_yearvalue) => print('onChangedYear: $_yearvalue'),
                    onChangedDay: (value) => {
                      _dayvalue=value,
                    print('onChangedDay: $value'),
                    },

                    onChangedMonth: (value) =>{
                      _monvalue=value,
                      print('onChangedMonth: $value'),
                      },

                    onChangedYear: (value) => {
                      _yearvalue=value,
                    print('onChangedYear: $value'),
                    },

                  ),
                ],
              ),
            )
        ),
        Step(
            state:_activeStepIndex<=1?StepState.editing : StepState.complete,
            isActive:_activeStepIndex>=1,
            title: const Text('Educational Information'),
            content:Container(
              child: Column(
                children: [
                  Container(
                    child:const Text("High School Details",style: TextStyle(
                      color: Colors.grey,
                    ),),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: highschoolcollegename,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'School Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: CustomDropdown(
                      fillColor: alabaster,
                      borderRadius: BorderRadius.circular(5),
                      hintText: 'Board',
                      hintStyle:  TextStyle(
                        color: Colors.grey[600],
                      ),
                      items: const ['State Board', 'CBSE Board', 'ICSE Board'],
                      controller: highschoolboard ,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: highschoolpercent,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Percent',
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    child:const Text("Intermediate Details",style: TextStyle(
                      color: Colors.grey,
                    ),),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: intermediatecollegename,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'School Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                    ),
                    child: CustomDropdown(
                      fillColor: alabaster,
                      borderRadius: BorderRadius.circular(5),
                      hintText: 'Board',
                      hintStyle:  TextStyle(
                        color: Colors.grey[600],
                      ),
                      items: const ['State Board', 'CBSE Board', 'ICSE Board'],
                      controller: intermediateboard,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: intermediatepercent,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:'Percent',
                    ),
                  ),

                ],
              ),
            )
        ),
        Step(
            state:StepState.complete,
            isActive:_activeStepIndex>=2,
            title: const Text('Document Upload'),
            content: Center(
              child: Column(
                children: [
                  CustomButton(
                      title: 'Upload Photograph',
                      icon: Icons.image_outlined,
                      onClick: ()=>getPhoto(ImageSource.gallery),
                  ),
                  const SizedBox(height: 20,),

                  _photo != null?Image.file(_photo!,width:250,height:250,fit:BoxFit.cover): Image.network('images/default-placeholder-image.png'),
                  const SizedBox(height: 40,),
                  CustomButton(
                    title: 'Upload Signature',
                    icon: Icons.image_outlined,
                    onClick: ()=>getSignature(ImageSource.gallery),
                  ),
                  const SizedBox(height: 20,),
                  _signature != null?Image.file(_signature!,width:250,height:250,fit:BoxFit.cover): Image.network('images/default-placeholder-image.png'),
                  const SizedBox(height: 40,),
                  CustomButton(
                    title: 'Upload Statement of Purpose',
                    icon: Icons.image_outlined,
                    onClick: ()=>getsop(ImageSource.gallery),
                  ),
                  const SizedBox(height: 20,),
                  _sop != null?Image.file(_sop!,width:250,height:250,fit:BoxFit.cover): Image.network('images/default-placeholder-image.png'),
                ],
              )
            )
        ),
        Step(

        state: StepState.complete,
        isActive: _activeStepIndex>=3,
        title: const Text('Confimation'),
        content: Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(child:_photo != null?Image.file(_photo!,width:250,height:250,fit:BoxFit.cover): Image.network('images/default-placeholder-image.png'),),
              const SizedBox(height: 40,),
              //Text('Name                  : ${name.text}'),
              apperance(
                title: 'Name',
                value: name.text,
                a: 180-46,
              ),
              //const SizedBox(height: 20,),
              //Text('Father Name     : ${fname.text}'),
              apperance(
                title: 'Father Name',
                value: fname.text,
                a: 137-46,
              ),
              //const SizedBox(height:20,),
              //Text('Mother Name    : ${mname.text}'),
              apperance(
                title: 'Mother Name',
                value: mname.text,
                a: 132-46,
              ),
              //Text('Email : ${email.text}'),
              apperance(
                title: 'Email',
                value: email.text,
                a: 183-46,
              ),
              //Text('Address : ${address.text}'),
              apperance(
                title: 'Address',
                value: address.text,
                // a: 166,
                a:120,
              ),
              //Text('Pin Code : ${pincode.text}'),
              apperance(
                title: 'Pin Code',
                value: pincode.text,
                a: 115,
              ),
              // Text('Date of Birth : ${_dayvalue}/${_monvalue}/${_yearvalue}',
              //   style: const TextStyle(
              //       fontWeight: FontWeight.bold
              // ),
              // ),
              Container(
                child: Row(
                  children: [
                    const Text('Date of Birth',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(width: 140-46,),
                    Text('${_dayvalue}/${_monvalue}/${_yearvalue}',style: const TextStyle(
                        fontWeight: FontWeight.w300
                    ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Center(
                child: Container(
                  child:const Text("High School Details",style: TextStyle(
                    color: Colors.grey,
                  ),),
                ),
              ),
              const SizedBox(height: 20,),
              //Text('School Name     ${highschoolcollegename.text}'),
              apperance(
                title: 'School Name',
                value: highschoolcollegename.text,
                a: 88,
              ),
              //Text('Board    ${highschoolboard.text}'),
              apperance(
                title: 'Board',
                value: highschoolboard.text,
                a: 134,
              ),
              //Text('Percent    : ${highschoolpercent.text}'),
              apperance(
                title: 'Percent',
                value: highschoolpercent.text,
                a: 125,
              ),
              const SizedBox(height: 30,),
              Center(
                child: Container(
                  child:const Text("Intermediate Details",style: TextStyle(
                    color: Colors.grey,
                  ),),
                ),
              ),
              //Text('School Name    : ${intermediatecollegename.text}'),
              const SizedBox(height: 20,),
              apperance(
                title: 'School Name',
                value: intermediatecollegename.text,
                a: 88,
              ),
              // Text('Board   : ${intermediateboard.text}'),
              apperance(
                title: 'Board',
                value: intermediateboard.text,
                a: 134,
              ),
              //Text('Percent    : ${intermediatepercent.text}'),
              apperance(
                title: 'Percent',
                value: intermediatepercent.text,
                a: 125,
              ),
              const SizedBox(height: 40,),
              _signature != null?Image.file(_signature!,width:300,height:150,fit:BoxFit.cover): Image.network('images/default-placeholder-image.png'),
            ],
          ) ,
        )
    )
      ];
Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 20,),
          Center(child: Text(title))
        ],
      ),
    ),
  );
}
  Widget apperance({
    required String title,
    required String value,
    required double a,
  }){
    return Container(
      child: Row(
        children: [
          Text(title,style: const TextStyle(
              fontWeight: FontWeight.w900
          ),
          ),
          SizedBox(width: a,),
          Text(value,style: const TextStyle(
              fontWeight: FontWeight.w300
          ),
          ),
        ],
      ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stepper(
          currentStep: _activeStepIndex,
            steps: stepList(),
          onStepContinue: (){
           if(_activeStepIndex<(stepList().length-1)){
             _activeStepIndex+=1;
           }
           setState((){

           });
          },
          onStepCancel: (){
            if(_activeStepIndex!=0){
              _activeStepIndex-=1;
            }
            setState((){

            });
          },
        )
    );
  }
}
