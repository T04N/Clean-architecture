import 'package:flutter/material.dart';
import 'package:nvvm/app/dependency_inject.dart';

import 'app/app.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await initAppModule();
initLoginModule();
  runApp(const MyApp());
}
