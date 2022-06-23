import 'dart:io';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Registration_Student extends StatefulWidget {
  const Registration_Student({Key? key}) : super(key: key);

  @override
  State<Registration_Student> createState() => _Registration_Student();
}

class _Registration_Student extends State<Registration_Student> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phonenum = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String? _dayvalue = '';
  String? _monvalue = '';
  String? _yearvalue = '';
  File? _photo;
  File? _signature;
  File? _aadhar;
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
        this._aadhar = imagePermanent;
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
  @override
  Widget build(BuildContext context) {

    final steps = [
      CoolStep(

        title: 'Basic Information',
        subtitle: 'Please fill some of the basic information to get started',

        content: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                labelText: 'Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value!)) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  if (value.length < 3) {
                    return "Cannot be shorter than 3 Character";
                  }
                  if (value.length > 15) {
                    return "Cannot be larger than 15 Character";
                  } else {
                    return null;
                  }
                },
                controller: _name,
              ),
              _buildTextField(
                labelText: 'Email Address',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email address is required';
                  } else {
                    return null;
                  }
                },
                controller: _email,
              ),
              _buildTextField(
                //keyboardType:TextInputType.phone,
                labelText: 'Phone Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone Number is required';
                  }
                  if (value.length != 10) {
                    return "Please enter valid phone number";
                  } else {
                    return null;
                  }
                },
                controller: _phonenum,
              ),
              _buildTextField(
                //keyboardType:TextInputType.phone,
                labelText: 'Address',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Address is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value!)) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  if (value.length < 3) {
                    return "Cannot be shorter than 3 Character";
                  }
                  if (value.length > 30) {
                    return "Cannot be larger than 15 Character";
                  } else {
                    return null;
                  }
                },
                controller: _address,
              ),
              _buildTextField(
                //keyboardType:TextInputType.phone,
                labelText: 'Enter Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 3) {
                    return "Too Short";
                  }
                  if (value.length > 15) {
                    return "Too long";
                  } else {
                    return null;
                  }
                },
                //obscureText : true,
                controller: _password,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                color: Colors.white,
                child: const Text(
                  "Date of Birth",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
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
                  _dayvalue = value,
                  print('onChangedDay: $value'),
                },

                onChangedMonth: (value) => {
                  _monvalue = value,
                  print('onChangedMonth: $value'),
                },

                onChangedYear: (value) => {
                  _yearvalue = value,
                  print('onChangedYear: $value'),
                },
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
          title: 'Document Upload',
          subtitle: 'To verify the identity of yours',
          content: Center(
              child: Column(
                children: [
                  CustomButton(
                    title: 'Upload Photograph',
                    icon: Icons.image_outlined,
                    onClick: () => getPhoto(ImageSource.gallery),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _photo != null
                      ? Image.file(_photo!,
                      width: 250, height: 250, fit: BoxFit.cover)
                      : Image.network('images/default-placeholder-image.png'),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    title: 'Upload Signature',
                    icon: Icons.image_outlined,
                    onClick: () => getSignature(ImageSource.gallery),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _signature != null
                      ? Image.file(_signature!,
                      width: 250, height: 250, fit: BoxFit.cover)
                      : Image.network('images/default-placeholder-image.png'),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    title: 'Upload Aadhar',
                    icon: Icons.image_outlined,
                    onClick: () => getsop(ImageSource.gallery),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _aadhar != null
                      ? Image.file(_aadhar!,
                      width: 250, height: 250, fit: BoxFit.cover)
                      : Image.network('images/default-placeholder-image.png'),
                ],
              )),
          validation: () {  }),
      CoolStep(
          title: 'Confirmation',
          subtitle: 'Recheck the entries you have made. You can change some of them in future',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(child: ClipOval(child:_photo != null?Image.file(_photo!,width:250,height:250,fit:BoxFit.cover): Image.network('images/default-placeholder-image.png'),)),
              const SizedBox(height: 40,),

              apperance(
                title: 'Name',
                value: _name.text,
                a: 134,
              ),
              Container(
                child: Row(
                  children: [
                    const Text('Date of Birth',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    const SizedBox(width: 91,),
                    Text('$_dayvalue/$_monvalue/$_yearvalue',style: const TextStyle(
                        fontWeight: FontWeight.w300
                    ),
                    ),
                  ],
                ),
              ),

              apperance(
                title: 'Email',
                value: _email.text,
                a: 183-48,
              ),

              apperance(
                title:'Phone Number',
                value:_phonenum.text,
                a:76,
              ),
              apperance(
                title: 'Address',
                value: _address.text,
                // a: 166,
                a:116,
              ),
              // Text('Date of Birth : ${_dayvalue}/${_monvalue}/${_yearvalue}',
              //   style: const TextStyle(
              //       fontWeight: FontWeight.bold
              // ),
              // ),

              const SizedBox(height: 30,),
              const SizedBox(height: 20,),
              const SizedBox(height: 40,),
              Center(child: _signature != null?Image.file(_signature!,width:300,height:150,fit:BoxFit.cover): Image.network('images/default-placeholder-image.png'),),
            ],
          ),
          validation: () {  }),
    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () {
        print('Steps completed!');
      },
      steps: steps,
      config: const CoolStepperConfig(
        backText: 'PREV',
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: const Text('Student Registration'),
    ),
      body:
          Container(child: stepper),
    );
  }

  Widget _buildTextField({
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }


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
}
