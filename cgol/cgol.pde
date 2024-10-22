Tile[][] grid;
float padding = 0;
int n = 250, gridHeight, gridWidth;
int speedPerSecond = 20;
float size;
boolean paused = true;

void setup() {
    size(1000, 840);
    size = (width - 2*padding) / n;

    gridWidth = n;
    gridHeight = int((height - 2*padding) / size);
    grid = new Tile[gridWidth][gridHeight];

    for (int x = 0; x < grid.length; x++) {
        for (int y = 0; y < grid[0].length; y++) {
            grid[x][y] = new Tile(x, y);
        }
    }
    // grid[0][1].alive = true;
    // grid[1][2].alive = true;
    // grid[2][2].alive = true;
    // grid[2][1].alive = true;
    // grid[2][0].alive = true;

    // grid[0][1].alive = true;
    // grid[1][1].alive = true;
    // grid[2][1].alive = true;
    frameRate(speedPerSecond);
}

void draw() {
    for (Tile[] column : grid) {
        for (Tile tile : column) {
            tile.draw();
        }
    }
    if (!paused) {
        for (Tile[] column : grid) {
            for (Tile tile : column) {
                tile.calc();
            }
        }
    }
    // noLoop();
}
