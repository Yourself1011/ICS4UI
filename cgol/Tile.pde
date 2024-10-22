class Tile {
    boolean alive = false, prevAlive = false;
    int x, y;
    Tile(int x, int y) {
        this.x = x;
        this.y = y;
    }

    void calc() {
        int liveNeighbors = getAliveNeighbors();
        // println(x, y, liveNeighbors);
        alive = (prevAlive && (liveNeighbors == 2 || liveNeighbors == 3)) || (!prevAlive && liveNeighbors == 3);
        // if (random(1) < 0.5) alive = true;
        // else alive = false;
    }

    int getAliveNeighbors() {
        int liveNeighbors = 0;
        for (int i = x-1; i <= x+1; i++) {
            for (int j = y-1; j <= y+1; j++) {
                // println(i, j);
                if (!(i == x && j == y) && grid[i == -1 ? gridWidth - 1 : i == gridWidth ? 0 : i][j == -1 ? gridHeight - 1 : j == gridHeight ? 0 : j].prevAlive) {
                    liveNeighbors++;
                }
            }
        }
        return liveNeighbors;
    }

    void draw() {
        if (alive) {
            fill(0);
        } else {
            fill(255);
        }
        square(x * size + padding, y * size + padding, size);
        prevAlive = alive;
    }
}