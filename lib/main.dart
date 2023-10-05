import 'package:blog_explorer/bloc/blogsbloc/blogs_state.dart';
import 'package:blog_explorer/bloc/blogsbloc/blogsbloc.dart';
import 'package:blog_explorer/cubit/Internet/internet_cubit.dart';
import 'package:blog_explorer/repositories/blogs_repository.dart';
import 'package:blog_explorer/views/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlogsBloc>(
          create: (context) => BlogsBloc(
              initialState: BlogsInitState(), blogsrepo: BlogsRepo()),
        ),
        BlocProvider<InternetConnectivityCubit>(create: (context) => InternetConnectivityCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            )),
            
        home: Homescreen(),
      ),
    );
  }
}
