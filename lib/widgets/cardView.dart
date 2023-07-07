// ignore_for_file: camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../routes/routes.dart';

class cardView extends StatelessWidget {
  const cardView({
    super.key,
    required Stream<QuerySnapshot<Object?>> usersStream3,
    required Stream<QuerySnapshot<Object?>> usersStream,
    required Stream<QuerySnapshot<Object?>> usersStream2,
    required this.rool,
  })  : _usersStream3 = usersStream3,
        _usersStream = usersStream,
        _usersStream2 = usersStream2;

  final Stream<QuerySnapshot<Object?>> _usersStream3;
  final Stream<QuerySnapshot<Object?>> _usersStream;
  final Stream<QuerySnapshot<Object?>> _usersStream2;

  // ignore: prefer_typing_uninitialized_variables
  final rool;

  @override
  Widget build(BuildContext context) {
    return rool == 'admin'
        ? SizedBox(
            height: 200,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.jassDetails);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.only(left: 10),
                    height: 180,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xff272D3D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Jas',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _usersStream3,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            int totaljass = snapshot.data!.docs.length;

                            return Column(
                              children: [
                                Text(
                                  'Total de jas: $totaljass',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            );
                          },
                        ),
                        Flexible(
                          child: LottieBuilder.asset(
                            'assets/jass.json',
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.userDetails);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.only(left: 10),
                    height: 180,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xff272D3D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Usuarios',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _usersStream,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            int totalUsers = snapshot.data!.docs.length;

                            return Column(
                              children: [
                                Text(
                                  'Total de usuarios: $totalUsers',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            );
                          },
                        ),
                        Flexible(
                          child: LottieBuilder.asset(
                            'assets/user.json',
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.productsDetails);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.only(left: 10),
                    height: 180,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xff272D3D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Productos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _usersStream2,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            int totalUsers = snapshot.data!.docs.length;

                            return Column(
                              children: [
                                Text(
                                  'Total de registros: $totalUsers',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            );
                          },
                        ),
                        Flexible(
                          child: LottieBuilder.asset(
                            'assets/productos2.json',
                            width: 200,
                            height: 400,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : rool == 'atm'
            ? SizedBox(
                height: 800,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  scrollDirection: Axis.vertical,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.jassDetails);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xff272D3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Jas',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: _usersStream3,
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                int totaljass = snapshot.data!.docs.length;

                                return Column(
                                  children: [
                                    Text(
                                      'Total de jas: $totaljass',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Flexible(
                              child: LottieBuilder.asset(
                                'assets/jass.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.userDetails);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xff272D3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Usuarios',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: _usersStream,
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                int totalUsers = snapshot.data!.docs.length;

                                return Column(
                                  children: [
                                    Text(
                                      'Total de usuarios: $totalUsers',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Flexible(
                              child: LottieBuilder.asset(
                                'assets/user.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.productsDetails);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xff272D3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Productos',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: _usersStream2,
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                int totalUsers = snapshot.data!.docs.length;

                                return Column(
                                  children: [
                                    Text(
                                      'Total de registros: $totalUsers',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Flexible(
                              child: LottieBuilder.asset(
                                'assets/productos2.json',
                                width: 200,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.asigProdsJass);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xff272D3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Asignar Productos a Jas',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            Flexible(
                              child: LottieBuilder.asset(
                                'assets/asignar.json',
                                width: 200,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ////// ING
            : SizedBox(
                height: 800,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  scrollDirection: Axis.vertical,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.jassDetails);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xff272D3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Jas',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: _usersStream3,
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                int totaljass = snapshot.data!.docs.length;

                                return Column(
                                  children: [
                                    Text(
                                      'Total de jas: $totaljass',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Flexible(
                              child: LottieBuilder.asset(
                                'assets/jass.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.userDetails);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xff272D3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Usuarios',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: _usersStream,
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                int totalUsers = snapshot.data!.docs.length;

                                return Column(
                                  children: [
                                    Text(
                                      'Total de usuarios: $totalUsers',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Flexible(
                              child: LottieBuilder.asset(
                                'assets/user.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.productsDetails);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xff272D3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Productos',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: _usersStream2,
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                int totalUsers = snapshot.data!.docs.length;

                                return Column(
                                  children: [
                                    Text(
                                      'Total de registros: $totalUsers',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Flexible(
                              child: LottieBuilder.asset(
                                'assets/productos2.json',
                                width: 200,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
