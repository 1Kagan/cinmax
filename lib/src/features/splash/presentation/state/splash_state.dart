import 'package:flutter/material.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class Authenticated extends SplashState {}

class Unauthenticated extends SplashState {}
