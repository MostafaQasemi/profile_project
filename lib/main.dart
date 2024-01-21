import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Example App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', '1'), // English
        Locale('fa', '98'), // Spanish
      ],
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.lightt().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggelThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark) {
              _themeMode = ThemeMode.light;
            } else {
              _themeMode = ThemeMode.dark;
            }
          });
        },
        selectedLanguageChange: (_Language newSelectedLanguageByUser) {
          setState(() {
            _locale = newSelectedLanguageByUser == _Language.en
                ? Locale('en')
                : Locale('fa');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = 'IRYekan';
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Color secondaryTextColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.lightt()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    // Color surfaceColore = Color(0x0dffffff);
    return ThemeData(
      primaryColor: primaryColor,
      brightness: brightness,
      secondaryHeaderColor: Colors.grey.shade900.withOpacity(0.8),
      dividerColor: Color(0x0dffffff),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: appBarColor),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ).merge(
          ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: surfaceColor),

      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      textTheme: languageCode == 'en' ? enPrimaryTextTheme : faprimaryTextTheme,

      useMaterial3: true,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(TextTheme(
        bodyMedium: TextStyle(
          fontSize: 13,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ));

  TextTheme get faprimaryTextTheme => TextTheme(
        bodyMedium: TextStyle(
          fontSize: 12,
          fontFamily: faPrimaryFontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontFamily: faPrimaryFontFamily,
        ),
        titleLarge: TextStyle(
            fontWeight: FontWeight.w200,
            fontFamily: faPrimaryFontFamily,
            fontSize: 16),
        titleMedium: TextStyle(
          height: 1.8,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: faPrimaryFontFamily,
        ),
      );
}

class MyHomePage extends StatefulWidget {
  final Function() toggelThemeMode;
  final Function(_Language _language) selectedLanguageChange;
  const MyHomePage(
      {super.key,
      required this.toggelThemeMode,
      required this.selectedLanguageChange});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum SkillType {
  photoshop,
  xd,
  illustrator,
  afterEffect,
  lightRoom,
}

class _MyHomePageState extends State<MyHomePage> {
  var _skill = SkillType.photoshop;
  void updatedSelectedSkills(SkillType skillType) {
    setState(() {
      this._skill = skillType;
    });
  }

  _Language _language = _Language.en;

  void _updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChange(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.profileTitle),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          InkWell(
            onTap: widget.toggelThemeMode,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(CupertinoIcons.ellipsis_vertical),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/profile_image.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(localization.job),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              size: 18,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              localization.location,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                  child: Text(
                    localization.summary,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  ),
                )
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Row(
                children: [
                  Text(
                    localization.selectedLanguage,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  CupertinoSlidingSegmentedControl<_Language>(
                      groupValue: _language,
                      thumbColor: Theme.of(context).primaryColor,
                      children: {
                        _Language.en: Text(localization.enLanguage),
                        _Language.fa: Text(localization.faLanguage)
                      },
                      onValueChanged: (value) {
                        if (value != null) _updateSelectedLanguage(value);
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 6),
              child: Row(
                children: [
                  Text(
                    localization.skills,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 12,
                  )
                ],
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              direction: Axis.horizontal,
              children: [
                Skill(
                  title: 'Photoshop',
                  imagePath: 'assets/images/app_icon_01.png',
                  isActive: _skill == SkillType.photoshop,
                  shadowColor: Colors.blue,
                  type: SkillType.photoshop,
                  ontap: () {
                    updatedSelectedSkills(SkillType.photoshop);
                  },
                ),
                Skill(
                  title: 'Adobe XD',
                  imagePath: 'assets/images/app_icon_05.png',
                  isActive: _skill == SkillType.xd,
                  shadowColor: Colors.pink,
                  type: SkillType.xd,
                  ontap: () {
                    updatedSelectedSkills(SkillType.xd);
                  },
                ),
                Skill(
                  title: 'AfterEffect',
                  imagePath: 'assets/images/app_icon_03.png',
                  isActive: _skill == SkillType.afterEffect,
                  shadowColor: Colors.blue,
                  type: SkillType.afterEffect,
                  ontap: () {
                    // updatedSelectedSkills(SkillType.afterEffect);
                    setState(() {
                      this._skill = SkillType.afterEffect;
                    });
                  },
                ),
                Skill(
                  title: 'Illustrator',
                  imagePath: 'assets/images/app_icon_04.png',
                  isActive: _skill == SkillType.illustrator,
                  shadowColor: Color.fromARGB(228, 248, 217, 95),
                  type: SkillType.illustrator,
                  ontap: () {
                    updatedSelectedSkills(SkillType.illustrator);
                  },
                ),
                Skill(
                  title: 'LightRoom',
                  imagePath: 'assets/images/app_icon_02.png',
                  isActive: _skill == SkillType.lightRoom,
                  shadowColor: Colors.blue,
                  type: SkillType.lightRoom,
                  ontap: () {
                    updatedSelectedSkills(SkillType.lightRoom);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 6),
              child: Row(
                children: [
                  Text(
                    localization.personalInformation,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 12,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 6),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.email,
                      prefixIcon: Icon(CupertinoIcons.at),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: localization.password,
                        prefixIcon: Icon(CupertinoIcons.lock)),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(localization.save),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Skill extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isActive;
  final Color shadowColor;
  final SkillType type;
  final Function() ontap;
  const Skill(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.isActive,
      required this.shadowColor,
      required this.type,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: ontap,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(16))
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor.withOpacity(0.5), blurRadius: 20)
                      ],
                    )
                  : null,
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

enum _Language {
  en,
  fa,
}
