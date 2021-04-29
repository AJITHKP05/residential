import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residential/blocs/cityDetails_cubit/citydetails_cubit.dart';
import 'package:residential/widgets/cityViewCard.dart';

import 'citySelection_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            foregroundImage: AssetImage(
              "assets/images/splashscreen.png",
            ),
          ),
        ),
        title: Text("Homes for you"),
      ),
      body: BlocProvider<CitydetailsCubit>(
        create: (context) => CitydetailsCubit()..fetch(),
        child: BlocBuilder<CitydetailsCubit, CitydetailsState>(
            builder: (ctx, state) {
          if (state is CitydetailsError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Something went wrong...!"),
                  Text("Check your network connecton"),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        print("button");
                        ctx.read<CitydetailsCubit>().fetch();
                      },
                      child: Text(
                        "RETRY",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          }
          if (state is CitydetailsLoaded) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                      child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.details.length,
                    itemBuilder: (context, index) =>
                        CityViewCard(city: state.details[index]),
                  )),
                ),
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CitySelectionPage(
                                first: false,
                              ),
                            ));
                      },
                      child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.green,
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_location_outlined,
                                color: Colors.blue[900],
                              ),
                              Text(
                                "Change Prefered Cities",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                  ),
                  bottom: 10,
                  right: 20,
                )
              ],
            );
          }
          return Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Loading..."),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
