import 'package:flutter/material.dart';
import 'package:mood_journal/features/welcome/state/onboarding_state.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {
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
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    final onboarding = context.watch<OnboardingState>();
    final currentTheme = onboarding.selectedTheme;
    final userName = onboarding.userName;

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child:
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      alignment: _isFirstLaunch ? const Alignment(0.0, -0.2): const Alignment(0.0, 0.45),
                      child:
                        AnimatedOpacity(
                          opacity: _opacity,
                          duration: const Duration(milliseconds: 500),
                          child:
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 20,
                                    offset: Offset(0, 10)
                                ),
                              ],
                            ),
                            child:
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _isFirstLaunch
                                      ? "Let's make this beautiful, $userName!"
                                      : "How are you doing today, $userName?",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF2E3E5C),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                  ),
                                ),

                                const SizedBox(height: 36),

                                Text(
                                  _isFirstLaunch
                                      ? "Your mindful journey starts right now. I'm here to listen to your thoughts every single day."
                                      : "Take a moment to check in with yourself. Tap the button below to add your first mood entry!",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    height: 1.4,
                                  ),
                                ),
                                if (_isFirstLaunch) ...[
                                  const SizedBox(height: 32,),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _isFirstLaunch = false;
                                      });
                                    },
                                    child:
                                    Container(
                                      width: double.maxFinite,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(28),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: currentTheme.colors
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: currentTheme.colors[0].withOpacity(0.3),
                                              blurRadius: 16,
                                              offset: Offset(0, 6)
                                          ),
                                        ],
                                      ),
                                      child:
                                      const Center(
                                        child: Text(
                                          "WRITE ON",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                    ),
                ),
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
                          Navigator.of(context).pushNamed('/check_in_flow_screen');
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
                                colors: currentTheme.colors
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: currentTheme.colors[0].withOpacity(0.15),
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
