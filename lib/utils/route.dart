import 'package:flutter/widgets.dart';
import 'package:pokemon_app/view/pages/detail_page.dart';
import '../view/pages/home_page.dart';

var routes = <String, Widget Function(BuildContext)>{
  '/': (context) => const HomePage(),
  '/detailPage': (context) => const DetailPage()
};
