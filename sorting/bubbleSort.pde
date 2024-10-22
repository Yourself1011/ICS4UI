
float[] bubbleSort(float[] list) {
    float temp;
    for (int p = 1; p < list.length - 1; p++) {
        for (int i = 1; i <= list.length - p; i++) {
            if (list[i] < list[i - 1]) {
                temp = list[i];
                list[i] = list[i - 1];
                list[i - 1] = temp;
            }
        }
    }

    return list;
}