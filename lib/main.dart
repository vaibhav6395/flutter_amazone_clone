import 'package:amazone_clonee/common/widgets/bottombar.dart';
import 'package:amazone_clonee/controller/authcontroller.dart';
import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/feature/admin/screen/adminscreen.dart';
import 'package:amazone_clonee/feature/auth/signin.dart';
import 'package:amazone_clonee/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (cotext) => User_Provider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Authcontroller authcontroller = Authcontroller();
  @override
  void initState() {
    super.initState();

    authcontroller.fetchuserdata(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: genereateRouter,
      

      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        // Use PredictiveBackPageTransitionsBuilder to get the predictive back route transition!
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
        // scaffoldBackgroundColor: Globls.primaryColor,
        colorScheme: const ColorScheme.light(
          // primary: globls,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.orangeAccent),
        ),
        useMaterial3: true, // can remove this line
      ),
      // onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<User_Provider>(context).user.token.isNotEmpty
          ? Provider.of<User_Provider>(context).user.type == 'user'
                ? const Bottombar()
                : const Adminscreen()
          : const Signin(),
    );
  }
}
