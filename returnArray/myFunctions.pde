float getAverage(float a, float b) {
    return (a + b) / 2;
}

float getAnyAverage(float... numbers) {
    float sum = 0;
    for (float n: numbers) {
        sum += n;
    }
    return sum / numbers.length;
}

float getArrayAverage(float[] numbers) {
    float sum = 0;
    for (float n: numbers) {
        sum += n;
    }
    return sum / numbers.length;
}