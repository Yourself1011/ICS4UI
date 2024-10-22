class Grid {
    // a 2 by 2 collection of tiles
    Tile[][] tiles;
    int width, height;

    Grid(int width, int height) {
        // For loading from new
        this.width = width;
        this.height = height;

        tiles = new Tile[width][height];
        for (int column = 0; column < width; column ++) {
            for (int row = 0; row < height; row++) {
                tiles[column][row] = new Tile(TileType.EMPTY, 0, new PVector(column * 10, row * 10), 10);
            }
        }
    }

    Grid(String[] data, int width, int height) {
        // For loading from file
        this.width = width;
        this.height = height;

        tiles = new Tile[width][height];
        String[] tilesData;
        for (int column = 0; column < width; column++) {
            tilesData = data[column].split(",");
            for (int row = 0; row < height; row++) {
                tiles[column][row] = new Tile(tilesData[row], new PVector(column * 10, row * 10), 10);
            }
        }
    }

    void draw() {
        rectMode(CORNER);
        for (Tile[] column : tiles) {
            for (Tile tile : column) {
                tile.draw();
            }
        }
    }

    String save() {
        String output = "";
        for (Tile[] column : tiles) {
            for (Tile tile : column) {
                output += tile.save() + ",";
            }
            output = output.substring(0, output.length() - 1) + "\n";
        }
        output += ";";

        return output;
    }
}
