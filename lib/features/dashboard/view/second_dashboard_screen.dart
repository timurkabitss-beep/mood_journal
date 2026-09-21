import 'package:flutter/material.dart';
import 'package:mood_journal/core/repositories/implementations/second_dashboard_repository.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:provider/provider.dart';

class SecondDashboardScreen extends StatefulWidget {
  const SecondDashboardScreen({super.key});

  @override
  State<SecondDashboardScreen> createState() => _SecondDashboardScreenState();
}
// TODO ИЗМЕНИТЬ ЛОГИКУ КНОПКИ И НАЗВАНИЕ КНОПКИ А ТАКЖЕ ИЗМЕНИТЬ ВИДЖЕТЫ И ПЕРЕХОДЫ
class _SecondDashboardScreenState extends State<SecondDashboardScreen> {
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

    final repo = SecondDashboardRepository(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child:
                AnimatedAlign(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  alignment: _isFirstLaunch ? const Alignment(0.0, -0.2): const Alignment(0.0, 0.65),
                  child:
                  AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 500),
                      child:
                      AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: _isFirstLaunch
                            ? BorderRadius.circular(28)
                            : BorderRadius.only(
                             topLeft: const Radius.circular(28),
                             topRight: const Radius.circular(28),
                             bottomLeft: const Radius.circular(28),
                             bottomRight: Radius.circular(5),
                        ),
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
                            state.firstText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF2E3E5C),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),

                          const SizedBox(height: 36),
                          Text.rich(
                            state.secondText,
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
                                    "AMAZING",
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
                  bottom: 0,
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
                                    Navigator.of(context).pushNamed(state.targetRoute);
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
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 70,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.grey.shade400,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
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
