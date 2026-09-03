String getWeatherCondition(int code) {
  if (code == 0) {
    return 'Clear sky';
  } else if (code == 1 || code == 2 || code == 3) {
    return 'Partly cloudy';
  } else if (code >= 45 && code <= 48) {
    return 'Fog';
  } else if (code >= 51 && code <= 57) {
    return 'Drizzle';
  } else if (code >= 61 && code <= 67) {
    return 'Rain';
  } else if (code >= 71 && code <= 77) {
    return 'Snow';
  } else if (code >= 80 && code <= 82) {
    return 'Rain showers';
  } else if (code >= 85 && code <= 86) {
    return 'Snow showers';
  } else if (code >= 95 && code <= 99) {
    return 'Thunderstorm';
  } else {
    return 'Unknown weather condition';
  }
}