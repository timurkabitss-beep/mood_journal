import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/mood': (context) => const MoodSelectScreen(),
      },
    ),
  );
}

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _CreateHomeScreen();
}

class _CreateHomeScreen extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap:(){
          print('Tap on!');
          Navigator.of(context).pushNamed("/mood");
        },
        child:
          Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:
                  [
                    Colors.purpleAccent,
                    Colors.blueAccent,
                  ]
              )
            ),
            child:
            SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child:
                      const Text("Привет!", style: TextStyle(color: Colors.white, fontSize: 30)),
                    ),
                    Center(
                      child:
                      const Text("Как проходит твой день?", style: TextStyle(color: Colors.white, fontSize: 30)),
                    ),
                    const SizedBox(height: 40,),
                  ],
                )
            ),
          )

      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.blueAccent,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}

class MoodSelectScreen extends StatelessWidget{
  const MoodSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:
        const Text("In this space Smile", style: TextStyle(fontSize: 30, color: Colors.black),)
      ),
    );
  }
}

