import 'package:firebase_auth/firebase_auth.dart';
import 'package:othmath/Pages/CommonService/CommunityServ.dart';
import 'package:othmath/Pages/MainPageService/About.dart';
import 'package:othmath/Pages/LoginService/MobLogin.dart';
import 'package:othmath/Pages/MainPageService/Honor.dart';
import 'package:othmath/Pages/TeacherService/Levels.dart';
import 'package:othmath/Pages/TeacherService/SS.dart';
import 'package:othmath/Pages/TeacherService/SpecialSub.dart';
import 'package:othmath/Pages/TeacherService/SubService.dart';
import 'package:othmath/Pages/TeacherService/ViewAssistants.dart';
import 'package:othmath/Pages/TeacherService/ViewStudents.dart';
import 'package:othmath/Pages/MainPageService/news.dart';
import 'package:othmath/Pages/SignupService/reg.dart';
import 'package:othmath/Pages/MainPageService/timetable.dart';
import 'package:othmath/Pages/TeacherService/teachersettings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:othmath/Subjects/Services.dart';
import 'package:othmath/Subjects/SpecialService.dart';
import 'firebase_options.dart';
import 'package:othmath/Pages/AssistantService/AssistantPage.dart';
import 'package:othmath/Pages/StudentService/MainPageAfterLogIN.dart';
import 'package:othmath/Pages/TeacherService/TeacherPage.dart';
import 'package:othmath/Pages/LoginService/AdminLogin.dart';
import 'dart:html' as html;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
html.window.onBeforeUnload.listen((event) async {
   FirebaseAuth.instance.signOut();
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const LoginAdmin(),
      '/login': (context) => const MobLogin(),
      '/news': (context) => const UnderDevelopmentPage(),
      '/timetable': (context) => const myTimetable(),
      '/aboutus': (context) => const Aboutus(),
      '/register': (context) => const RegisterPage(),
      '/main': (context) => const MainpageALG(email: "", Name: ""),
      '/othmath': (context) => const LoginAdmin(),
      '/teacher': (context) => const Teacherpage(
            Email: "",
            ID: "",
            Name: "",
          ),
      '/students': (context) => const ViewStudents(),
      '/Myassistants': (context) => const ViewAssistant(),
      '/tasks': (context) => const UnderDevelopmentPage(),
      '/books': (context) => const UnderDevelopmentPage(),
      '/assigments': (context) => const UnderDevelopmentPage(),
      '/videos': (context) => const UnderDevelopmentPage(),
      '/assistant': (context) => const Assistantpage(
            Email: "",
            ID: "",
            Name: "",
          ),
      '/community': (context) => const CommunityServ(
            email: "",
            Role: "",
          ),
      '/teachersettings': (context) => const settingteacher(),
      '/honor': (context) => const Honors(),
      '/mysubjects': (context) => const SubjectServices(
            role: "",
            subjectName: "",
          ),
      '/subjects': (context) => const SubServices(
            role: "",
            subjectName: "",
          ),
      '/levels': (context) => SecondaryLevelSelection(),
      '/sub': (context) => const SS(
            Level: '',
          ), '/specialsub': (context) => const SpecialSub(
              Level: '',
            ),'/classsub': (context) => const SpecialSubjectServices(
              className: "",
              subjectName: "",
            ),
    },
  ));
}
