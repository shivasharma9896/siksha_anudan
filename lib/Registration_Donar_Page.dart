import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:siksha_anudan/Doner%20Home.dart';
import 'package:siksha_anudan/model/Donor_model.dart';

class Registration_Donor extends StatefulWidget {
  const Registration_Donor ({Key? key}) : super(key: key);

  @override
  State<Registration_Donor > createState() => _Registration_Donor ();
}

class _Registration_Donor extends State<Registration_Donor > {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phonenum = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _aadharC = TextEditingController();
  final TextEditingController _pancard = TextEditingController();
  String? _dayvalue = '';
  String? _monvalue = '';
  String? _yearvalue = '';
  String? photourl = "";
  String? signurl = "";
  String? aadharurl = "";
  String? dob;
  File? _photo;
  File? _signature;
  File? _aadhar;
  bool _isLoading = false;
  Future getPhoto(ImageSource source) async{
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 70);
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
                  if (value.length > 50) {
                    return "Cannot be larger than 50 Character";
                  } else {
                    return null;
                  }
                },
                controller: _address,
              ),
              _buildTextField(
                //keyboardType:TextInputType.phone,
                labelText: 'Enter Aadhar Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Aadhar is required';
                  }
                  if (value.length < 11) {
                    return "Too Short";
                  }
                  if (value.length > 11) {
                    return "Too long";
                  } else {
                    return null;
                  }
                },
                //obscureText : true,
                controller: _aadharC,
              ),
              _buildTextField(
                //keyboardType:TextInputType.phone,
                labelText: 'Enter Pancard Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Pan is required';
                  }
                  if (value.length < 9) {
                    return "Too Short";
                  }
                  if (value.length > 9) {
                    return "Too long";
                  } else {
                    return null;
                  }
                },
                //obscureText : true,
                controller: _pancard,
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
                height: 5,
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
                    title: 'Upload Pancard',
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
                a: 99,
              ),
              Container(
                child: Row(
                  children: [
                    const Text('Date of Birth',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    const SizedBox(width:56 ,),
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
                //a: 135,
                a:100,
              ),

              apperance(
                title:'Phone Number',
                value:_phonenum.text,
                a:76-35,
              ),
              apperance(
                title: 'Address',
                value: _address.text,
                // a: 166,
                a:120-35,
              ),
              apperance(
                title: 'Aadhar Number',
                value: _aadharC.text,
                // a: 166,
                a:72-35,
              ),
              apperance(
                title: 'Pancard Number',
                value: _pancard.text,
                // a: 166,
                a:65-35,
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
        //Fluttertoast.showToast(msg: 'Registered successfully');
        signUp(_email.text, _password.text);
        print('Steps completed!');
      },
      steps: steps,
      config: const CoolStepperConfig(
        backText: 'PREV',
      ),
    );

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      opacity: 0.8,
      color: Colors.black,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Donor Registration",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(child: stepper),
          ],
        ),
      ),
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

  void signUp(String email, String password) async {
    try {
      setState(() {
        _isLoading = true;
      });
      dob = "${_dayvalue!}/${_monvalue!}/${_yearvalue!}";
      if(_photo == null || _signature ==null || _aadhar==null){
        Fluttertoast.showToast(msg: "Please upload Documents");
      }
      else{
        final ref = FirebaseStorage.instance
            .ref()
            .child("DonorDocs")
            .child('${_aadharC.text}_photo.jpg');
        await ref.putFile(_photo!);
        photourl = await ref.getDownloadURL();

        final ref1 = FirebaseStorage.instance
            .ref()
            .child("DonorDocs")
            .child('${_aadharC.text}_sign.jpg');
        await ref1.putFile(_signature!);
        signurl = await ref1.getDownloadURL();

        final ref3 = FirebaseStorage.instance
            .ref()
            .child("DonorDocs")
            .child('${_aadharC.text}_aadhar.jpg');
        await ref3.putFile(_aadhar!);
        aadharurl = await ref3.getDownloadURL();

        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password);
        postDetailsToFirestore();
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

    postDetailsToFirestore() async{
      //calling our firestore
      //calling our model
      //sending these values
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = auth.currentUser;
      DonorModel donorModel = DonorModel();

      donorModel.email = user!.email;
      donorModel.uid = user.uid;
      donorModel.name = _name.text;
      donorModel.phonenum = _phonenum.text;
      donorModel.address = _address.text;
      donorModel.aadharC = _aadharC.text;
      donorModel.pancard = _pancard.text;
      donorModel.photourl = photourl;
      donorModel.signurl = signurl;
      donorModel.aadharurl = aadharurl;
      donorModel.dob = dob;

      await firebaseFirestore
          .collection("Donor")
          .doc(user.uid)
          .set(donorModel.toMap());
      Fluttertoast.showToast(msg: "Account created successfully!");
      //Navigator.pushNamed(this.context,'/d-home');
      Navigator.pushAndRemoveUntil(this.context, MaterialPageRoute(builder: (context) => DonerHome()), (route) => false);
      //Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => DonerHome()), (route) => false);
  }
}
