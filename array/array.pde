void setup() {
    int[] dMarks = {100, 96, 88, 100, 85, 7};
    
    for (int i = 0; i < dMarks.length; i++) {
        dMarks[i] += 10;
    }
    
    float total = 0;
    for (int mark : dMarks) {
        total += mark;
    }
    println(total / dMarks.length);
    
    float[] xVals = new float[10];
    float[] yVals = new float[10];
    
    for (int i = 0; i < xVals.length; i++) {
        xVals[i] = 50 + i * 10;
        yVals[i] = 0.03 * pow(xVals[i], 2) - 20 * xVals[i] + 10;
    }
    // println(xVals);
    // println(yVals);
    
    float[] bob;
    
    int n = int(random(10, 20));
    bob = new float[n];
    for (int i = 0; i < n; i++) {
        bob[i] = random( -1, 1);
    }
    println(bob);
}

void draw() {
    
}
