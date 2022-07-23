import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:jobhiring/splash_screen/splash_screen.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/states/contractor.dart';
import 'package:jobhiring/states/create_account.dart';
import 'package:jobhiring/states/employer.dart';
import 'package:jobhiring/states/markerjob.dart';
import 'package:jobhiring/states/mode.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';

import 'infoHandler/app_info.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => const Authen(),
  '/createaccount': (BuildContext context) => const CreateAccount(),
  '/employer': (BuildContext context) => const Employer(),
  '/contractor': (BuildContext context) => const Contractor(),
  '/mode': (BuildContext context) => const Mode(),
  '/markerjob': (BuildContext context) => const MarkerJob(),
};

String? initlalRoute;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   initlalRoute = MyConstant.routeAuthen;
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: MyConstant.appName,
//       routes: map,
//       //initialRoute: initlalRoute,
//       home: const MySplashScreen(),
//     );
//   }
// }

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(
      child: ChangeNotifierProvider(
        create: (context) => AppInfo(),
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'), // English
            Locale('th', 'TH'), // Thai
          ],
          title: 'JobHiring',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MySplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget
{
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  Key key = UniqueKey();

  void restartApp()
  {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}

// final _timePickerTheme = TimePickerThemeData(
//   backgroundColor: Colors.white,
//   // hourMinuteShape: RoundedRectangleBorder(
//   //   borderRadius: BorderRadius.all(Radius.circular(8)),
//   //   side: BorderSide(color: MyConstant.primary, width: 4),
//   // ),
//   dayPeriodBorderSide: const BorderSide(color: Colors.orange, width: 4),
//   dayPeriodColor: Colors.blueGrey.shade600,
//   shape: const RoundedRectangleBorder(
//     borderRadius: BorderRadius.all(Radius.circular(8)),
//     side: BorderSide(color: Colors.orange, width: 4),
//   ),
//   dayPeriodTextColor: Colors.black,
//   dayPeriodShape: const RoundedRectangleBorder(
//     borderRadius: BorderRadius.all(Radius.circular(8)),
//     side: BorderSide(color: Colors.orange, width: 4),
//   ),
//   hourMinuteColor: MaterialStateColor.resolveWith((states) =>
//   states.contains(MaterialState.selected) ? Colors.orange : Colors.blueGrey.shade800),
//   hourMinuteTextColor: MaterialStateColor.resolveWith(
//           (states) => states.contains(MaterialState.selected) ? Colors.white : Colors.orange),
//   dialHandColor: Colors.blueGrey.shade700,
//   dialBackgroundColor: Colors.blueGrey.shade800,
//   hourMinuteTextStyle: MyConstant().headbar(),
//   dayPeriodTextStyle: MyConstant().headbar(),
//   helpTextStyle: MyConstant().jobmoney(),
//   inputDecorationTheme: const InputDecorationTheme(
//     border: InputBorder.none,
//     contentPadding: EdgeInsets.all(8),
//   ),
//   dialTextColor: MaterialStateColor.resolveWith(
//           (states) => states.contains(MaterialState.selected) ? Colors.orange : Colors.white),
//   entryModeIconColor: Colors.orange,
// );

