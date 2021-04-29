import 'package:flutter/material.dart';
import 'package:residential/models/cityDetail.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CityViewCard extends StatelessWidget {
  final CityDetail city;

  const CityViewCard({Key? key, required this.city}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.grey.withOpacity(.3),
            width: size.width * .9,
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showImages(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5),
                    child: Text(
                      city.address,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  detaiView(Icons.location_on_outlined, city.province,
                      color: Colors.blue),
                  detaiView(Icons.toggle_off_sharp, "\$ " + city.price),
                  detaiView(
                      Icons.meeting_room_outlined, city.bedroom + " BedRooms"),
                  detaiView(Icons.bathtub, city.bathrooms + " BathRooms"),
                  if (city.sqft != "")
                    detaiView(Icons.aspect_ratio, city.sqft + " SQFT"),
                  SizedBox(
                    height: 05,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  detaiView(IconData icon, String data, {Color? color}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              data,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      );

  List<String>? getImages() {
    if (city.image.images == null)
      return null;
    else {
      List<String> image = [];
      List<String> list = city.image.images!.split(
        ",",
      );
      list.forEach((element) {
        image.add(city.image.directory +
            "Photo" +
            city.image.num +
            "-" +
            element +
            ".jpeg");
      });
      if (image.length > 3) return image.sublist(0, 3);
      return image;
    }
  }

  showImages(context) {
    final size = MediaQuery.of(context).size;
    List<String>? list = getImages();
    if (list == null)
      return Image.asset(
        "assets/images/splashscreen.jpg",
        height: size.height * .4,
        fit: BoxFit.cover,
      );
    return Container(
      height: size.height * .4,
      // width: 200,
      child: CarouselSlider.builder(
          itemCount: list.length,
          itemBuilder: (context, index, realIndex) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/splashscreen.jpg",
                image: list[index],
                height: size.height * .4,
                fit: BoxFit.cover,
              )),
          options: CarouselOptions(
            height: size.height * .4,
            disableCenter: true,
            pauseAutoPlayOnTouch: true,
            autoPlay: true,
          )),
      // scrollDirection: Axis.horizontal,
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      // itemBuilder: (context, index) => Image.network(
      //       list[index],
      //       height: size.height * .4,
      //       fit: BoxFit.cover,
      //     )),
    );
  }
}
