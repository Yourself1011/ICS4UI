void setup() {
    println(h(5));
    exit();
}

void draw() {}

float h(float x) {
    if (x <= 1 / 2) return 2;
    return 3 * h(x - 1) + 4;
}