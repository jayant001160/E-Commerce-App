import 'package:e_commerce_app/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderSetup extends StatelessWidget {
  final Widget child;

  const ProviderSetup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: child,
    );
  }
}
