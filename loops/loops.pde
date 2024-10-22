void setup() {
    size(512, 512);
    float sum = 0;
    for (float i = 1; i <= 100; i += 0.5) {
        sum += i;
    }
    println(sum);

    for (float deg = 0; deg <= 30; deg++) {
        float LS = cos(radians(deg)/2);
        float RS = sqrt((1 + cos(radians(deg)))/2);
        println(deg, LS, "=", RS);
    }

    for (float deg = 0; deg <= 30; deg++) {
        float LS = sin(3*radians(deg));
        float RS = 4*sin(radians(deg))*sin(PI/3-radians(deg))*sin(PI/3+radians(deg));
        println(deg, LS, "=", RS);
    }

    for (int x = 0; x < 10; x++) {
        for (int y = 0; y < 6; y++) {
            square(x * 50, y * 50, 50);
        }
    }
}

void draw() {
    
}
