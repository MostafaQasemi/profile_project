import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pink.shade400,
        secondaryHeaderColor: Colors.grey.shade900.withOpacity(0.8),
        dividerColor: Color(0x0dffffff),
        scaffoldBackgroundColor: Color.fromARGB(255, 30, 30, 30),
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.latoTextTheme(TextTheme(
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
        )),

        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curriculum Vitae'),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: Icon(CupertinoIcons.ellipsis_vertical),
          ),
        ],
      ),
      body: Column(
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
                        'Brice Séraphin',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text('Product& Product Designer'),
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
                            'Paris, France',
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
                    'Enthusiastic young computer Geek, Freelance Designer in love of independence, I have alot of experience in graphical projects, and always give the best of myself to bring you to success.'),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Row(
              children: [
                Text(
                  'skills',
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
          // ignore: prefer_const_constructors
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
                shadowColor: Color.fromARGB(255, 224, 178, 1),
                type: SkillType.afterEffect,
                ontap: () {
                  updatedSelectedSkills(SkillType.afterEffect);
                },
              ),
              Skill(
                title: 'Illustrator',
                imagePath: 'assets/images/app_icon_04.png',
                isActive: _skill == SkillType.illustrator,
                shadowColor: Color.fromARGB(21, 101, 192, 1),
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
        ],
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
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
