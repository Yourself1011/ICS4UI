class GridCollection {
    // Collection of grids to represent the floors
    Grid current;
    int index = 0, width, height, levels;
    Grid[] grids;

    GridCollection(int levels, int width, int height) {
        this.levels = levels;
        this.width = width;
        this.height = height;
        grids = new Grid[levels];

        for (int i = 0; i < levels; ++i) {
            grids[i] = new Grid(width, height);
        }

        this.current = grids[index];
    }

    GridCollection() throws Exception {
        String[] collectionData = reader.readLine().split(",");
        this.levels = int(collectionData[2]);
        this.width = int(collectionData[0]);
        this.height = int(collectionData[1]);
        grids = new Grid[levels];

        String[] gridData = new String[width];
        for (int i = 0; i < levels; ++i) {
            for (int j = 0; j < width; ++j) {
                gridData[j] = reader.readLine();
            }

            grids[i] = new Grid(gridData, width, height);
            gridData = new String[width];
            reader.readLine();
        }

        this.current = grids[index];
    }

    void moveTo(int index) {
        this.index = index;
        current = grids[index];
    }

    void moveUp() {
        if (index < levels - 1) {
            moveTo(index + 1);
        }
    }

    void moveDown() {
        if (index > 0) {
            moveTo(index - 1);
        }
    }

    void save(String file) {
        PrintWriter printWriter = createWriter(file);

        printWriter.println(width + "," + height + "," + levels);
        for (Grid grid : grids) {
            printWriter.println(grid.save());
        }

        printWriter.flush();
        printWriter.close();
    }
}