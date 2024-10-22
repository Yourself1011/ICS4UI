void setup() {
    printArrayOnOneLine(
        bubbleSort(new float[]{9, 8, 7, 6, 2, 7, 3, 1, 21, 5, 4, 3, 2, 1, 0, 3})
    );

    printArrayOnOneLine(insertionSort(
        new float[]{9, 8, 7, 6, 2, 7, 3, 1, 21, 5, 4, 3, 2, 1, 0, 3}
    ));

    printArrayOnOneLine(
        mergeSort(new float[]{9, 8, 7, 6, 2, 7, 3, 1, 21, 5, 4, 3, 2, 1, 0, 3})
    );

    println(mostInstances(
        new float[]{5, 1, 5, -4, 16, 5, 1, 1, 3, 1, 17, 16, 5, 21, 5, 20, 5, 3}
    ));

    exit();
}

void draw() {}
