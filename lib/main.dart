import 'package:fitnessapp/controllers/nutrition_controller.dart';
import 'package:fitnessapp/controllers/plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/main_tab_controller.dart';
import 'utils/app_colors.dart';
import 'views/main_screen.dart';

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainTabController()),
        ChangeNotifierProvider(create: (_) => PlanController()),
        ChangeNotifierProvider(create: (_) => NutritionController())
      ],
      child: MaterialApp(
        title: 'Fitness App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
