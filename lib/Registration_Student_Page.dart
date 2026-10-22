import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:siksha_anudan/StudentHome_Page.dart';
import 'package:siksha_anudan/model/Student_model.dart';

class RegistrationStudent extends StatefulWidget {
  const RegistrationStudent({Key? key}) : super(key: key);

  @override
  State<RegistrationStudent> createState() => _RegistrationStudent();
}

class _RegistrationStudent extends State<RegistrationStudent> {
  static const _useTestData = bool.fromEnvironment('USE_TEST_DATA');
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _educationFormKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phonenum = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _aadharC = TextEditingController();
  final TextEditingController _pan = TextEditingController();
  final TextEditingController highschoolcollegename = TextEditingController();
  final TextEditingController highschoolboard = TextEditingController();
  final TextEditingController highschoolpercent = TextEditingController();
  final TextEditingController intermediatecollegename = TextEditingController();
  final TextEditingController intermediateboard = TextEditingController();
  final TextEditingController intermediatepercent = TextEditingController();
  final TextEditingController degappfor = TextEditingController();
  final TextEditingController amountreq = TextEditingController();
  final TextEditingController income = TextEditingController();

  String? _dayvalue = _useTestData ? '1' : '';
  String? _monvalue = _useTestData ? '1' : '';
  String? _yearvalue = _useTestData ? '2000' : '';
  String? photourl = "";
  String? signurl = "";
  String? aadharurl = "";
  String? dob;
  File? _photo;
  File? _signature;
  File? _aadhar;
  bool _isLoading = false;
  Future getPhoto(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 70);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = File(image.path);

      setState(() {
        _photo = imagePermanent;
      });
      debugPrint('Selected student photo: ${imagePermanent.path}');
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future getSignature(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 70);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = File(image.path);

      setState(() {
        _signature = imagePermanent;
      });
      debugPrint('Selected student bonafide: ${imagePermanent.path}');
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future getsop(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 70);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = File(image.path);

      setState(() {
        _aadhar = imagePermanent;
      });
      debugPrint('Selected student SOP: ${imagePermanent.path}');
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        title: 'Basic Information',
        subtitle: 'Please fill some of the basic information to get started',
        content: Form(
          key: _basicInfoFormKey,
          child: Column(
            children: [
              _buildTextField(
                fieldKey: const ValueKey('registration-name'),
                labelText: 'Name',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Name is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value ?? '')) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  if ((value ?? '').length < 3) {
                    return "Cannot be shorter than 3 Character";
                  }
                  if ((value ?? '').length > 30) {
                    return "Cannot be larger than 15 Character";
                  } else {
                    return null;
                  }
                },
                controller: _name,
              ),
              _buildTextField(
                fieldKey: const ValueKey('registration-email'),
                labelText: 'Email Address',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Email address is required';
                  }
                  if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value ?? '')) {
                    return "Invalid Email Id";
                  } else {
                    return null;
                  }
                },
                controller: _email,
              ),
              _buildNumberField(
                fieldKey: const ValueKey('registration-phone'),
                //keyboardType:TextInputType.phone,
                labelText: 'Phone Number',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Phone Number is required';
                  }
                  if ((value ?? '').length != 10) {
                    return "Please enter valid phone number";
                  } else {
                    return null;
                  }
                },
                controller: _phonenum,
              ),
              _buildTextField(
                fieldKey: const ValueKey('registration-address'),
                //keyboardType:TextInputType.phone,
                labelText: 'Address',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Address is required';
                  }
                  if (!RegExp(r'[a-zA-Z\-0-9]+$').hasMatch(value ?? '') &&
                      !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                          .hasMatch(value ?? '')) {
                    return "Invalid Address";
                  }
                  if ((value ?? '').length < 3) {
                    return "Cannot be shorter than 3 Character";
                  }
                  if ((value ?? '').length > 30) {
                    return "Cannot be larger than 30 Character";
                  } else {
                    return null;
                  }
                },
                controller: _address,
              ),
              _buildNumberField(
                fieldKey: const ValueKey('registration-aadhaar'),
                labelText: 'Enter Aadhar Number',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Aadhar is required';
                  }
                  if ((value ?? '').length < 11) {
                    return "Too Short";
                  }
                  if ((value ?? '').length > 12) {
                    return "Too long";
                  } else {
                    return null;
                  }
                },
                //obscureText : true,
                controller: _aadharC,
              ),
              const SizedBox(
                height: 12,
              ),
              _buildTextField(
                fieldKey: const ValueKey('registration-pan'),
                //keyboardType:TextInputType.phone,
                labelText: 'PAN Number',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'PAN Number is required';
                  }
                  if (!RegExp(r'[a-zA-Z\-0-9]+$').hasMatch(value ?? '') &&
                      !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                          .hasMatch(value ?? '')) {
                    return "Invalid Address";
                  }
                  if ((value ?? '').length < 3) {
                    return "Cannot be shorter than 3 Character";
                  }
                  if ((value ?? '').length > 10) {
                    return "Cannot be larger than 15 Character";
                  } else {
                    return null;
                  }
                },
                controller: _pan,
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
              Semantics(
                label: 'registration-date-of-birth',
                child: KeyedSubtree(
                  key: const ValueKey('registration-date-of-birth'),
                  child: DropdownDatePicker(
                    boxDecoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ), // optional
                    isDropdownHideUnderline: true, // optional
                    isFormValidator: true, // optional
                    startYear: 1950, // optional
                    endYear: 2020, // optional
                    selectedDay: _useTestData ? 1 : null,
                    selectedMonth: _useTestData ? 1 : null,
                    selectedYear: _useTestData ? 2000 : null,
                    width: 10, // optional
                    // onChangedDay: (_dayvalue) => print('onChangedDay: $_dayvalue'),
                    //  onChangedMonth: (_monvalue) => print('onChangedMonth: $_monvalue'),
                    //  onChangedYear: (_yearvalue) => print('onChangedYear: $_yearvalue'),
                    onChangedDay: (value) => {
                      _dayvalue = value,
                      debugPrint('onChangedDay: $value'),
                    },

                    onChangedMonth: (value) => {
                      _monvalue = value,
                      debugPrint('onChangedMonth: $value'),
                    },

                    onChangedYear: (value) => {
                      _yearvalue = value,
                      debugPrint('onChangedYear: $value'),
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                key: const ValueKey('registration-degree'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: CustomDropdown(
                  // fillColor: Colors.alabaster,
                  borderRadius: BorderRadius.circular(5),
                  hintText: 'Degree Applied For',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  items: const [
                    'B.A',
                    'B.Arch',
                    'B.C.A',
                    'B.Com',
                    'B.Sc',
                    'B.Tech',
                    'M.B.A',
                    'M.C.A',
                    'M.Tech'
                  ],
                  controller: degappfor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              KeyedSubtree(
                key: const ValueKey('registration-family-income'),
                child: CustomDropdown(
                  // fillColor: Colors.alabaster,
                  borderRadius: BorderRadius.circular(5),
                  hintText: "Family Income",
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  items: const [
                    "Below 1,00,000",
                    "1,00,000 - 3,00,000",
                    "4,00,000 - 7,00,000",
                    "7,00,000 - 10,00,000"
                  ],
                  controller: income,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              _buildNumberField(
                fieldKey: const ValueKey('registration-amount'),
                //keyboardType:TextInputType.phone,
                labelText: 'Amount required for Donation',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Required';
                  } else {
                    return null;
                  }
                },
                controller: amountreq,
              ),
              _buildTextField(
                fieldKey: const ValueKey('registration-password'),
                //keyboardType:TextInputType.phone,
                labelText: 'Enter Password',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Password is required';
                  }
                  if ((value ?? '').length < 3) {
                    return "Too Short";
                  }
                  if ((value ?? '').length > 15) {
                    return "Too long";
                  } else {
                    return null;
                  }
                },
                //obscureText : true,
                controller: _password,
              ),
            ],
          ),
        ),
        validation: () {
          if (!_basicInfoFormKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'Educational Qualification',
        subtitle: 'Enter you education you have been done so far',
        content: Form(
          key: _educationFormKey,
          child: Column(
            children: [
              const Text(
                "High School Details",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              _buildTextField(
                fieldKey: const ValueKey('registration-high-school-name'),
                labelText: 'School Name',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'School Name is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value ?? '')) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  if ((value ?? '').length < 5) {
                    return "Cannot be shorter than 5 Character";
                  }
                  if ((value ?? '').length > 30) {
                    return "Cannot be larger than 30 Character";
                  } else {
                    return null;
                  }
                },
                controller: highschoolcollegename,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                key: const ValueKey('registration-high-school-board'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: CustomDropdown(
                  // fillColor: Colors.alabaster,
                  borderRadius: BorderRadius.circular(5),
                  hintText: 'Board',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  items: const ['State Board', 'CBSE Board', 'ICSE Board'],
                  controller: highschoolboard,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(
                fieldKey: const ValueKey('registration-high-school-percent'),
                labelText: 'Percent',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Percent is required';
                  }
                  // if (!RegExp(r'^(\d+|\d*[.]\d+)%?$').hasMatch(value ?? '')) {
                  //   return "Invalid(Special Character are not allowed)";
                  // }
                  if ((value ?? '').length != 2) {
                    return 'Invalid Percentage';
                  }
                  if (!RegExp(r'^\d+([.]\d+)?%?$').hasMatch(value ?? '')) {
                    return "Percent cannot have Special Character/Alphabet";
                  } else {
                    return null;
                  }
                },
                controller: highschoolpercent,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Intermediate Details",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              _buildTextField(
                fieldKey: const ValueKey('registration-intermediate-name'),
                labelText: 'School Name',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'School Name is required';
                  }
                  if (!RegExp(r'[a-z A-Z]+$').hasMatch(value ?? '')) {
                    return "Invalid(Special Character are not allowed)";
                  }
                  if ((value ?? '').length < 5) {
                    return "Cannot be shorter than 5 Character";
                  }
                  if ((value ?? '').length > 30) {
                    return "Cannot be larger than 30 Character";
                  } else {
                    return null;
                  }
                },
                controller: intermediatecollegename,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                key: const ValueKey('registration-intermediate-board'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: CustomDropdown(
                  // fillColor: Colors.alabaster,
                  borderRadius: BorderRadius.circular(5),
                  hintText: 'Board',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  items: const ['State Board', 'CBSE Board', 'ICSE Board'],
                  controller: intermediateboard,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(
                fieldKey: const ValueKey('registration-intermediate-percent'),
                labelText: 'Percent',
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Percent is required';
                  }
                  // if (!RegExp(r'^(\d+|\d*[.]\d+)%?$').hasMatch(value ?? '')) {
                  //   return "Invalid(Special Character are not allowed)";
                  // }
                  if ((value ?? '').length != 2) {
                    return 'Invalid Percentage';
                  }
                  if (!RegExp(r'^\d+([.]\d+)?%?$').hasMatch(value ?? '')) {
                    return "Percent cannot have Special Character/Alphabet";
                  } else {
                    return null;
                  }
                },
                controller: intermediatepercent,
              ),
            ],
          ),
        ),
        validation: () {
          if (!_educationFormKey.currentState!.validate()) {
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
              customButton(
                buttonKey: const ValueKey('registration-upload-photo'),
                title: 'Upload Photograph',
                icon: Icons.image_outlined,
                onClick: () => getPhoto(ImageSource.gallery),
              ),
              const SizedBox(
                height: 20,
              ),
              //'assets/images/siksha_logo.svg'
              _photo != null
                  ? Image.file(_photo!,
                      width: 250, height: 250, fit: BoxFit.cover)
                  : Image.asset('assets/images/default-placeholder-image.png'),
              const SizedBox(
                height: 40,
              ),
              customButton(
                buttonKey: const ValueKey('registration-upload-bonafide'),
                title: 'Upload Bonafide Certificate',
                icon: Icons.image_outlined,
                onClick: () => getSignature(ImageSource.gallery),
              ),
              const SizedBox(
                height: 20,
              ),
              _signature != null
                  ? Image.file(_signature!,
                      width: 250, height: 250, fit: BoxFit.cover)
                  : Image.asset('assets/images/default-placeholder-image.png'),
              const SizedBox(
                height: 40,
              ),
              customButton(
                buttonKey: const ValueKey('registration-upload-sop'),
                title: 'Upload SOP',
                icon: Icons.image_outlined,
                onClick: () => getsop(ImageSource.gallery),
              ),
              const SizedBox(
                height: 20,
              ),
              _aadhar != null
                  ? Image.file(_aadhar!,
                      width: 250, height: 250, fit: BoxFit.cover)
                  : Image.asset('assets/images/default-placeholder-image.png'),
            ],
          )),
          validation: () => null),
      CoolStep(
          title: 'Confirmation',
          subtitle:
              'Recheck the entries you have made. You can change some of them in future',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: ClipOval(
                child: _photo != null
                    ? Image.file(_photo!,
                        width: 250, height: 250, fit: BoxFit.cover)
                    : Image.asset(
                        'assets/images/default-placeholder-image.png'),
              )),
              const SizedBox(
                height: 40,
              ),

              apperance(
                title: 'Name',
                value: _name.text,
                a: 94,
              ),
              Row(
                children: [
                  const Text(
                    'Date of Birth',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 51,
                  ),
                  Text(
                    '$_dayvalue/$_monvalue/$_yearvalue',
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),

              apperance(
                title: 'Email',
                value: _email.text,
                a: 95,
              ),

              apperance(
                title: 'Phone Number',
                value: _phonenum.text,
                a: 36,
              ),
              apperance(
                title: 'Address',
                value: _address.text,
                // a: 166,
                a: 78,
              ),
              // Text('Date of Birth : ${_dayvalue}/${_monvalue}/${_yearvalue}',
              //   style: const TextStyle(
              //       fontWeight: FontWeight.bold
              // ),
              // ),

              const SizedBox(
                height: 40,
              ),
              const Center(
                child: Text(
                  "High School Details",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Text('School Name     ${highschoolcollegename.text}'),
              apperance(
                title: 'School Name',
                value: highschoolcollegename.text,
                // a: 88,
                a: 47,
              ),
              //Text('Board    ${highschoolboard.text}'),
              apperance(
                title: 'Board',
                value: highschoolboard.text,
                a: 92,
              ),
              //Text('Percent    : ${highschoolpercent.text}'),
              apperance(
                title: 'Percent',
                value: highschoolpercent.text,
                a: 125 - 44,
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  "Intermediate Details",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              //Text('School Name    : ${intermediatecollegename.text}'),
              const SizedBox(
                height: 20,
              ),
              apperance(
                title: 'School Name',
                value: intermediatecollegename.text,
                a: 47,
              ),
              // Text('Board   : ${intermediateboard.text}'),
              apperance(
                title: 'Board',
                value: intermediateboard.text,
                a: 134 - 43,
              ),
              //Text('Percent    : ${intermediatepercent.text}'),
              apperance(
                title: 'Percent',
                value: intermediatepercent.text,
                a: 125 - 43,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: _signature != null
                    ? Image.file(_signature!,
                        width: 300, height: 150, fit: BoxFit.cover)
                    : Image.asset(
                        'assets/images/default-placeholder-image.png'),
              ),
            ],
          ),
          validation: () => null),
    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () async {
        Fluttertoast.showToast(msg: 'Registered successfully');
        await signUp(_email.text, _password.text);
        debugPrint('Steps completed!');
      },
      steps: steps,
      config: const CoolStepperConfig(
        backText: 'PREV',
      ),
    );

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Student Registration",
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
    Key? fieldKey,
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        key: fieldKey,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        scrollPadding: const EdgeInsets.only(bottom: 180),
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget _buildNumberField({
    Key? fieldKey,
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        key: fieldKey,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        keyboardType: TextInputType.number,
        scrollPadding: const EdgeInsets.only(bottom: 180),
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget customButton({
    Key? buttonKey,
    required String title,
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return SizedBox(
      key: buttonKey,
      width: 280,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 20,
            ),
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
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        SizedBox(
          width: a,
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  Future<void> signUp(String email, String password) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (_photo == null || _signature == null || _aadhar == null) {
        debugPrint(
          'Registration blocked: photo=${_photo != null}, '
          'bonafide=${_signature != null}, sop=${_aadhar != null}',
        );
        Fluttertoast.showToast(msg: "Please upload all required documents");
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      dob = "$_dayvalue/$_monvalue/$_yearvalue";
      debugPrint('Creating emulator registration for $email');
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final uid = credential.user!.uid;
      final storage = FirebaseStorage.instance.ref();

      final photoRef = storage.child("studentPhotos/$uid/profile.jpg");
      final imageMetadata = SettableMetadata(contentType: 'image/png');
      await photoRef.putFile(_photo!, imageMetadata);
      photourl = await photoRef.getDownloadURL();

      final signatureRef = storage.child("studentDocuments/$uid/signature.jpg");
      await signatureRef.putFile(_signature!, imageMetadata);
      signurl = signatureRef.fullPath;

      final identityRef =
          storage.child("studentDocuments/$uid/identity-document.jpg");
      await identityRef.putFile(_aadhar!, imageMetadata);
      aadharurl = identityRef.fullPath;

      await postDetailsToFirestore();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      } else {
        Fluttertoast.showToast(msg: 'Registration failed. Please try again.');
      }
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: 'Registration failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> postDetailsToFirestore() async {
    final user = auth.currentUser!;
    final studentModel = StudentModel(
      amountReq: int.parse(amountreq.text),
      amountRec: 0,
      email: user.email,
      uid: user.uid,
      name: _name.text,
      phonenum: _phonenum.text,
      address: _address.text,
      aadharC: _aadharC.text,
      aadharurl: aadharurl,
      appFor: degappfor.text,
      highschoolboard: highschoolboard.text,
      highschoolcollegename: highschoolcollegename.text,
      highschoolpercent: highschoolpercent.text,
      intermediatecollegename: intermediatecollegename.text,
      intermediateboard: intermediateboard.text,
      intermediatepercent: intermediatepercent.text,
      photourl: photourl,
      signurl: signurl,
      dob: dob,
      status: "pending",
      income: income.text,
    );

    final firestore = FirebaseFirestore.instance;
    await firestore.collection("StudentPublic").doc(user.uid).set(
          studentModel.toPublicMap(),
        );
    await firestore.collection("StudentPrivate").doc(user.uid).set(
          studentModel.toPrivateMap(),
        );
    Fluttertoast.showToast(msg: "Account created successfully!");
    if (const bool.fromEnvironment('USE_TEST_DATA')) {
      return;
    }
    if (!mounted) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentHome()),
    );
  }
}
