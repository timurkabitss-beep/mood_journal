import 'package:flutter/material.dart';
import 'package:mood_journal/core/repositories/implementations/first_dashboard_repository.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:provider/provider.dart';

class FirstDashboardScreen extends StatefulWidget {
  const FirstDashboardScreen({super.key});

  @override
  State<FirstDashboardScreen> createState() => _FirstDashboardScreenState();
}


class _FirstDashboardScreenState extends State<FirstDashboardScreen> {
  double _opacity = 0.0;
  bool _isFirstLaunch = true;



  @override
  void initState(){
    Future.delayed(Duration(milliseconds:500), (){
      if (mounted){
        setState(() {
        _opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final onboarding = context.watch<AppState>();
    final currentTheme = onboarding.selectedTheme;
    final userName = onboarding.userName;

    final repo = FirstDashboardRepository(
        userName: userName,
        themeColor: currentTheme.colors,
    );
    final state = repo.loadDashboardState(isFirstLaunch: _isFirstLaunch);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: _opacity ==0.0 ?
          Color(0xFFE4E7ED) :
          Color.alphaBlend(Colors.black.withOpacity(0.05), const Color(0xFFE4E7ED)) ,
          child:
          SafeArea(
              child:
              Stack(
                children:[
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  bottom: _isFirstLaunch ? -120 : 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    child: BottomAppBar(
                        color: Colors.white,
                        notchMargin: 8.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 8.0,
                            bottom: 24.0,
                          ),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.wb_sunny_outlined, color: Colors.black38, size: 30,),
                                onPressed: () {

                                },
                              ),
                              const SizedBox(width: 24),
                              IconButton(
                                icon: const Icon(Icons.format_quote_outlined, color: Colors.black38, size: 30,),
                                onPressed:  (){

                                },
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.show_chart_rounded, color: Colors.black38, size: 30,),
                                onPressed: () {

                                },
                              ),
                              const SizedBox(width: 24),
                              IconButton(
                                icon: const Icon(Icons.emoji_people_outlined, color: Colors.black38, size: 30,),
                                onPressed: (){

                                },
                              )
                            ],
                          ),
                        )
                    ) ,
                  )
                ),
                AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubic,
                    bottom: _isFirstLaunch ? -80 : 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(state.targetRoute);
                        },
                        child: 
                        Container(
                          width: 70,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: state.themeColors
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: state.themeColors[0].withOpacity(0.15),
                                  blurRadius: 14,
                                  offset: Offset(0, 6)
                              ),
                            ],
                          ),
                          child: Center(
                            child:  Icon(Icons.add, color: Colors.white, size: 30,)
                          ),
                        ),
                      ),
                    ),
                ),
               ],
              ),
          ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.white,
        elevation: 0,
        height: 10,
      ),

    );
  }
}
