import 'package:flutter/material.dart';

IconData getWeatherIcon(int code) {
  if (code == 0) {
    return Icons.wb_sunny;
  }

  if (code == 1) {
    return Icons.wb_cloudy_outlined;
  }

  if (code == 2 || code == 3) {
    return Icons.cloud;
  }

  if (code >= 45 && code <= 48) {
    return Icons.foggy;
  }

  if (code >= 51 && code <= 57) {
    return Icons.grain;
  }

  if (code >= 61 && code <= 67) {
    return Icons.cloudy_snowing;
  }

  if (code >= 71 && code <= 77) {
    return Icons.ac_unit;
  }

  if (code >= 80 && code <= 82) {
    return Icons.cloudy_snowing;
  }

  if (code >= 95 && code <= 99) {
    return Icons.thunderstorm;
  }

  return Icons.cloud;
}