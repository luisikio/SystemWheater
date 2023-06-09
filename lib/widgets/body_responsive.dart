import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/constants/constants.dart';

class BodyResponsive extends StatelessWidget {
  const BodyResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Column(
        children: [
          BodyHomePage(),
        ],
      ),
    );
  }
}

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;

    return Expanded(
      flex: 12,
      child: wid > 1000
          ? Row(
              children: [
                Expanded(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      padding: const EdgeInsets.all(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: BounceInLeft(
                              child: const Text(
                                'Sistema de Control de Agua',
                                style: TextStyle(
                                  color: Color(0xff1F2432),
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 80),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(151, 158, 158, 158),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                '"Con WaterSystem, llevamos el control y la eficiencia al manejo del agua en tu hogar, mejorando la calidad de vida al garantizar un recurso vital puro y disponible, para que puedas centrarte en lo que realmente importa: disfrutar de los momentos que la vida te ofrece".',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 50,
                  ),
                  child: Column(
                    children: [
                      const Expanded(
                        child: Text(''),
                      ),
                      Expanded(
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image(
                                image: AssetImage(
                                  ciudades[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          autoplay: true,
                          loop: true,
                          viewportFraction: 0.8,
                          scale: 0.9,
                          itemCount: ciudades.length,
                          pagination: const SwiperPagination(),
                          control: const SwiperControl(),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Expanded(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              child: BounceInLeft(
                                child: const Text(
                                  'Sistema de Control de Agua',
                                  style: TextStyle(
                                    color: Color(0xff1F2432),
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(151, 158, 158, 158),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              '"Con WaterSystem, llevamos el control y la eficiencia al manejo del agua en tu hogar, mejorando la calidad de vida al garantizar un recurso vital puro y disponible, para que puedas centrarte en lo que realmente importa: disfrutar de los momentos que la vida te ofrece".',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image(
                            image: AssetImage(
                              ciudades[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      autoplay: true,
                      loop: true,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      itemCount: ciudades.length,
                      pagination: const SwiperPagination(),
                      control: const SwiperControl(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
