void setup() {
    float avgPrice = getAverage(99.45, 12.88);
    float avgCoolness = getAverage(5, 1);
    float avgSleep = getAverage(7, 8);
    println(avgPrice, avgCoolness, avgSleep);

    println(getAnyAverage(1, 2, 3, 4, 5));
    println(getArrayAverage((float[]) {1, 2, 3, 4, 5}));
}

void draw() {
    
}
