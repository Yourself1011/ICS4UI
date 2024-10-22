void printArrayOnOneLine(float[] list) {
    for (int i = 0; i < list.length - 1; i++) {
        print(list[i] + ", ");
    }
    println(list[list.length - 1]);
}