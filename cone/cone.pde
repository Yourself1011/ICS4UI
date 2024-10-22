void setup() {
    println(getConeVolume(5.0, 20));
    println(getConeVolume(-8, 20));
    println(getConeVolume(12, -300));
    println(getConeVolume(21, 68));
}

float getConeVolume(float h, float r) {
  if (h < 0 || r < 0) return 0;

  return PI*pow(r, 2)*h/3;
}