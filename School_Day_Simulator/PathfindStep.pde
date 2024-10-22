class PathfindStep {
    int x, y, level, dist;

    PathfindStep(int x, int y, int level, int dist) {
        this.x = x;
        this.y = y;
        this.level = level;
        this.dist = dist;
    }

    PathfindStep(int x, int y, int level) {
        this.x = x;
        this.y = y;
        this.level = level;
    }

    ArrayList<PVector> getValidNeighbors(int[][][] distanceMatrix) {
        ArrayList<PVector> neighbors = new ArrayList<PVector>();
        if (x > 0 && (gridCollection.grids[level].tiles[x-1][y].type != TileType.WALL && gridCollection.grids[level].tiles[x-1][y].type != TileType.OFFICE) && distanceMatrix[level][x-1][y] == Integer.MAX_VALUE) {
            neighbors.add(new PVector(x-1, y, level));
        }
        if (x < gridCollection.width-1 && (gridCollection.grids[level].tiles[x+1][y].type != TileType.WALL && gridCollection.grids[level].tiles[x+1][y].type != TileType.OFFICE) && distanceMatrix[level][x+1][y] == Integer.MAX_VALUE) {
            neighbors.add(new PVector(x+1, y, level));
        }
        
        if (y > 0 && (gridCollection.grids[level].tiles[x][y-1].type != TileType.WALL && gridCollection.grids[level].tiles[x][y-1].type != TileType.OFFICE) && distanceMatrix[level][x][y-1] == Integer.MAX_VALUE) {
            neighbors.add(new PVector(x, y-1, level));
        }
        if (y < gridCollection.height-1 && (gridCollection.grids[level].tiles[x][y+1].type != TileType.WALL && gridCollection.grids[level].tiles[x][y+1].type != TileType.OFFICE) && distanceMatrix[level][x][y+1] == Integer.MAX_VALUE) {
            neighbors.add(new PVector(x, y+1, level));
        }
        
        if (level > 0 && (gridCollection.grids[level-1].tiles[x][y].type != TileType.WALL && gridCollection.grids[level-1].tiles[x][y].type != TileType.OFFICE) && gridCollection.grids[level].tiles[x][y].type == TileType.STAIRS && gridCollection.grids[level].tiles[x][y].variant == 0 && distanceMatrix[level-1][x][y] == Integer.MAX_VALUE) {
            neighbors.add(new PVector(x, y, level-1));
        }
        if (level < gridCollection.levels-1 && (gridCollection.grids[level+1].tiles[x][y].type != TileType.WALL && gridCollection.grids[level+1].tiles[x][y].type != TileType.OFFICE) && gridCollection.grids[level].tiles[x][y].type == TileType.STAIRS && gridCollection.grids[level].tiles[x][y].variant == 1 && distanceMatrix[level+1][x][y] == Integer.MAX_VALUE) {
            neighbors.add(new PVector(x, y, level+1));
        }

        Collections.shuffle(neighbors);
        return neighbors;
    }

    ArrayList<PVector> getValidNeighbors() {
        ArrayList<PVector> neighbors = new ArrayList<PVector>();
        if (x > 0 && gridCollection.grids[level].tiles[x-1][y].type != TileType.WALL && gridCollection.grids[level].tiles[x-1][y].type != TileType.OFFICE) {
            neighbors.add(new PVector(x-1, y, level));
        }
        if (x < gridCollection.width-1 && gridCollection.grids[level].tiles[x+1][y].type != TileType.WALL && gridCollection.grids[level].tiles[x+1][y].type != TileType.OFFICE) {
            neighbors.add(new PVector(x+1, y, level));
        }
        
        if (y > 0 && gridCollection.grids[level].tiles[x][y-1].type != TileType.WALL && gridCollection.grids[level].tiles[x][y-1].type != TileType.OFFICE) {
            neighbors.add(new PVector(x, y-1, level));
        }
        if (y < gridCollection.height-1 && gridCollection.grids[level].tiles[x][y+1].type != TileType.WALL && gridCollection.grids[level].tiles[x][y+1].type != TileType.OFFICE) {
            neighbors.add(new PVector(x, y+1, level));
        }
        
        if (level > 0 && gridCollection.grids[level-1].tiles[x][y].type != TileType.WALL && gridCollection.grids[level-1].tiles[x][y].type != TileType.OFFICE && gridCollection.grids[level].tiles[x][y].type == TileType.STAIRS && gridCollection.grids[level].tiles[x][y].variant == 0) {
            neighbors.add(new PVector(x, y, level-1));
        }
        if (level < gridCollection.levels-1 && gridCollection.grids[level+1].tiles[x][y].type != TileType.WALL && gridCollection.grids[level+1].tiles[x][y].type != TileType.OFFICE && gridCollection.grids[level].tiles[x][y].type == TileType.STAIRS && gridCollection.grids[level].tiles[x][y].variant == 1) {
            neighbors.add(new PVector(x, y, level+1));
        }

        Collections.shuffle(neighbors);
        return neighbors;
    }
}