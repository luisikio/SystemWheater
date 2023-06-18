import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/routes/routes.dart';
import 'package:sistem_weatherv2/screens/register/register_jass.dart';
import 'package:sistem_weatherv2/screens/register/register_prodcutos.dart';

import 'package:sistem_weatherv2/screens/register/register_screen.dart';
import 'package:sistem_weatherv2/screens/users_screen/atm/asignar_productsJass.dart';
import 'package:sistem_weatherv2/screens/users_screen/atm/enviar_productos.dart';
import 'package:sistem_weatherv2/screens/users_screen/home_screen_user.dart';
import 'package:sistem_weatherv2/screens/users_screen/ing_especialista/details_cloracion.dart';
import 'package:sistem_weatherv2/screens/users_screen/ing_especialista/details_monitoreo.dart';
import 'package:sistem_weatherv2/screens/users_screen/super_admin/details_jass.dart';
import 'package:sistem_weatherv2/screens/users_screen/super_admin/details_products.dart';
import 'package:sistem_weatherv2/screens/users_screen/super_admin/details_users.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_operario/registros_cloracion.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_operario/registros_monitoreo.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_profile/edit_jass.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_profile/edit_products.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_profile/edit_profile.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_profile/edit_profile_op.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_profile/user_profile.dart';

import '../screens/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/users_screen/reset_password.dart/reset_password.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.login: (context) => const LoginScreen(),
    Routes.home: (context) => const HomeScreen(),
    Routes.registro: (context) => const RegisterScreen(),
    Routes.homeuserscreen: (context) => const HomeScreenUsers(),
    Routes.registerProductos: (context) => const ProductosScreeen(),
    Routes.resetpasswordscreemd: (context) => const ResetPasswordScreen(),
    Routes.userprofile: (context) => const ProfileScreen(),
    Routes.edituserprofile: (context) => const EditProfileScreen(),
    Routes.jassscreen: (context) => const JassRegisterScreeen(),
    Routes.registrosCloraOperario: (context) => const RegistroCloracionScreen(),
    Routes.registrosMonitOperario: (context) => const RegistroMonitoreoScreen(),
    Routes.userDetails: (context) => const UserDetailsScreen(),
    Routes.jassDetails: (context) => const JassDetailsScreen(),
    Routes.cloracionDetails: (p0) => const DetailsCloracionScreen(),
    Routes.monitoreoDetails: (p0) => const DetailsMonitoreoScreen(),
    Routes.editjassDetails: (context) => const EditJassScreen(),
    Routes.productsDetails: (context) => const ProductsDetailsScreen(),
    Routes.editproductsDetails: (context) => const EditProductsScreen(),
    Routes.asigProdsJass: (context) => const AsignarProdcJassScreen(),
    Routes.edituserOperprofile: (p0) => const EditProfileOperarioScreen(),
    Routes.enviarProdsJass: (p0) => const EnviarProductosScreen(),
  };
}
