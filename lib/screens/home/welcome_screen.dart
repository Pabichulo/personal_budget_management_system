import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_budget_managemet/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:personal_budget_managemet/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:personal_budget_managemet/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:personal_budget_managemet/screens/auth/sign_in_screen.dart';
import 'package:personal_budget_managemet/screens/auth/sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
   late TabController tabController;

    @override
    void initState(){
      tabController = TabController(
        initialIndex: 0,
        length: 2, 
        vsync: this
        );
        super.initState();
    }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(20, -1.2),
                child:  Container(
                   height:  MediaQuery.of(context).size.width,
                   width: MediaQuery.of(context).size.width,
                   decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary
                   ),
                ),
              ),

              Align(
                alignment: const AlignmentDirectional(-2.7, -1.2),
                child:  Container(
                   height:  MediaQuery.of(context).size.width / 1.3,
                   width: MediaQuery.of(context).size.width / 1.3,
                   decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiary
                   ),
                ),
              ),

              Align(
                alignment: const AlignmentDirectional(2.7, -1.2),
                child:  Container(
                   height:  MediaQuery.of(context).size.width / 1.3,
                   width: MediaQuery.of(context).size.width / 1.3,
                   decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary
                   ),
                ),
              ),

              BackdropFilter(
                filter: ImageFilter.blur(sigmaX:150.0, sigmaY:150.0),
                child: Container(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height:  MediaQuery.of(context).size.height / 1.2,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Center(
                          child: Text(
                            "PERSONAL BUDGET TRACKER",
                            style: TextStyle(
                              color: Colors.white, // You can change this to any color you like
                              fontSize: 20.0, // You can change this to any font size you like
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: TabBar(
                            controller: tabController,
                            unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                            labelColor: Theme.of(context).colorScheme.onSurface,
                            tabs: const [
                               Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                ),
                              ),

                                Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                ),
                              ),

                             
                            ],
                          )
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children:  [
                              BlocProvider<SignInBloc>(
															create: (context) => SignInBloc(
																userRepository: context.read<AuthenticationBloc>().userRepository
															),
															child: const SignInScreen(),
														),
														BlocProvider<SignUpBloc>(
															create: (context) => SignUpBloc(
																userRepository: context.read<AuthenticationBloc>().userRepository
															),
															child: const SignUpScreen(),
														),
                            ],
                          )
                        )
                    ],
                  ),
                  )
              )
            ],
            
          )          ),
        )
      );
  }
}