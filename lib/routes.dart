import 'package:medical_app/Screen/home_screen.dart';
import 'package:medical_app/Screen/lab_upload.dart';
import 'package:medical_app/Screen/medicine_screen.dart';
import 'package:medical_app/authantication/loginScreen.dart';

const intialroute = "/";
const loginScreen = "/LoginScreen";

const homeScreen = "/HomeScreen";
// ignore: constant_identifier_names
const labUpload = "/LabUpload";
// ignore: constant_identifier_names
const medi_screen = "/MediScreen";

final route = {
  loginScreen: (context) => const LoginScreen(),
  homeScreen: (context) => HomeScreen(),
  labUpload: (context) => const LabUpload(),
  medi_screen: (context) => MedicineScreen(
        selectedIndex: 0,
      ),
};
