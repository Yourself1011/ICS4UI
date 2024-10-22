class Course {
    // A class to store all classroom tiles of a class type, and help students choose courses
    String name;
    float[] probabilities;
    int i = 0;
    ArrayList<PVector> positions = new ArrayList<PVector>();

    Course(String name, float[] probabilities) {
        this.name = name;
        this.probabilities = probabilities;
    }

    void reset() {
        i = 0;
    }

    void choose() {
        i++;
    }

    float getWeight() {
        return i >= probabilities.length ? 0 : probabilities[i];
    }
}