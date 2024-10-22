float[] mergeSort(float[] list) {
    if (list.length == 1)
        return list;

    int midPoint = list.length / 2;
    float[] left = mergeSort(subset(list, 0, midPoint));
    float[] right = mergeSort(subset(list, midPoint));
    float[] result = new float[list.length];

    int i = 0, j = 0;
    while (true) {
        if (left[i] < right[j]) {
            result[i + j] = left[i];
            i++;
        } else {
            result[i + j] = right[j];
            j++;
        }

        if (i >= left.length) {
            for (; j < right.length; j++) {
                result[i + j] = right[j];
            }
            return result;
        } else if (j >= right.length) {
            for (; i < left.length; i++) {
                result[i + j] = left[i];
            }
            return result;
        }
    }
}