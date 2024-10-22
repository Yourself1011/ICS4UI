float f(float x) {
    return sqrt(x + 5);
}

float KE(float m, float v) {
    return 0.5*m*pow(v, 2);
}

String getRandomYesNo(float prob) {
    return random(0, 100) <= prob ? "yes" : "no";
}

float roundDigit(float x, int d) {
    return round(x*pow(10, d))/pow(10, d);
}

float middleRandom(float min, float max) {
    return (random(min, max) + random(min, max))/2;
}