float[] insertionSort(float[] list) {
    for (int i = 1; i < list.length; i++) {
        float x = list[i];
        int j;
        for (j = i - 1; j >= 0 && list[j] > x; j--) {
            list[j + 1] = list[j];
        }
        list[j + 1] = x;
    }
    return list;
}