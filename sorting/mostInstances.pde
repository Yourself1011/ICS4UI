float mostInstances(float[] list) {
    HashMap map = new HashMap<Float, Integer>();

    float highestNum = 0;
    int highestCount = 0;

    for (float item : list) {
        if (map.containsKey(item)) {
            map.put(item, (int)map.get(item) + 1);
        } else {
            map.put(item, 1);
        }

        if ((int)map.get(item) > highestCount) {
            highestNum = item;
            highestCount = (int)map.get(item);
        }
    }

    return highestNum;
}