int[][] teamScores = new int[5][3];

void setup() {
    for (int i = 0; i < teamScores.length; ++i) {
        for (int j = 0; j < teamScores[0].length; ++j) {
            teamScores[i][j] = round(random(0, 100));
        }
    }

    // print
    for (int i = 0; i < teamScores.length; ++i) {
        for (int j = 0; j < teamScores[0].length; ++j) {
            print(teamScores[i][j] + "\t");
        }
        print("\n");
    }

    // calculate
    println("Totals");
    for (int j = 0; j < teamScores[0].length; ++j) {
        int sum = 0;
        for (int i = 0; i < teamScores.length; ++i) {
            sum += teamScores[i][j];
        }
        print(sum);
        print("\t");
    }
}

void draw() {
    
}
