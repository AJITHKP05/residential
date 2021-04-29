import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residential/blocs/selectCities_cubit/selectcities_cubit.dart';
import 'package:residential/models/city.dart';
import 'package:residential/pages/homePage.dart';

class CitySelectionPage extends StatefulWidget {
  final bool first;

  const CitySelectionPage({Key? key, this.first = true}) : super(key: key);
  @override
  _CitySelectionPageState createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider<SelectcitiesCubit>(
            create: (context) =>
                SelectcitiesCubit()..fetch(first: widget.first),
            child: BlocListener<SelectcitiesCubit, SelectcitiesState>(
              listener: (context, state) {
                if (state is SelectcitiesSkip) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                }
              },
              child: BlocBuilder<SelectcitiesCubit, SelectcitiesState>(
                  builder: (ctx, state) {
                if (state is SelectcitiesInitial)
                  return dataView(state.cities, size, ctx);
                if (state is SelectcitiesSaved)
                  return dataView(state.cities, size, ctx);
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            )));
  }

  dataView(Cities cities, Size size, BuildContext ctx) => SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * .2),
                child: Text(
                  "Select your prefered cities",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cities.cities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CheckboxListTile(
                        activeColor: Colors.deepOrange,
                        selectedTileColor: Colors.blue[200],
                        title: Text("${cities.cities[index].name}"),
                        onChanged: (val) {
                          cities.cities.insert(index,
                              cities.cities[index].copyWith(selected: val));
                          cities.cities.removeAt(index + 1);
                          setState(() {});
                        },
                        value: cities.cities[index].selected,
                      ),
                    );
                  }),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    },
                    child: Text(
                      "later",
                      style: TextStyle(color: Colors.grey),
                    )),
                ElevatedButton(
                    onPressed: () {
                      ctx.read<SelectcitiesCubit>().saveData(cities);
                    },
                    child: Text("Save")),
              ],
            )
          ],
        ),
      );
}
