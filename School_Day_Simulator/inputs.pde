void keyPressed() {
    if (mousePressed) handleMouse();

    switch(Character.toLowerCase(key)) {
        // movement
        case 'w':
            cameraPos.y += zoom * 10;
            break;
        case 'a':
            cameraPos.x += zoom * 10;
            break;
        case 's':
            cameraPos.y -= zoom * 10;
            break;
        case 'd':
            cameraPos.x -= zoom * 10;
            break;

        // zoom
        case '=':
            zoom *= 1.1;
            break;
        case '-':
            zoom *= 0.9;
            break;

        // toggle path
        case 'p':
            path = !path;
            break;

        // start simulation
        case ' ':
            period = 0;
            totalMinutes = 485;
            minutesPerSecond = 0.5;
            totalLunchDesirability = 1; // chance for starting square (going home)
            started = true;

            for (Course course : courses) {
                course.positions.clear();
            }

            // record all positions of every course
            String variantName;
            for (int level = 0; level < gridCollection.levels; level++) {
                for (Tile[] column : gridCollection.grids[level].tiles) {
                    for (Tile tile : column) {
                        tile.lunchDesirability = -1;
                        if (tile.type.equals(TileType.CLASS)) {
                            variantName = TileType.CLASS.variants[tile.variant];

                            for (Course course : courses) {
                                if (course.name.equals(variantName)) {
                                    course.positions.add(new PVector(tile.pos.x, tile.pos.y, level));
                                    break;
                                }
                            }
                        }
                    }
                }
            }

            // Assign a lunch desirability rating to each tile
            ArrayList<PathfindStep> queue = new ArrayList<PathfindStep>();
            queue.add(new PathfindStep(0, 0, 0));
            while (!queue.isEmpty()) {
                //bfs
                PathfindStep step = queue.remove(0);
                for (PVector neighbor : step.getValidNeighbors()) {
                    Tile tile = gridCollection.grids[int(neighbor.z)].tiles[int(neighbor.x)][int(neighbor.y)];

                    if (tile.lunchDesirability == -1) {
                        float desirability = 0;

                        if (tile.type == TileType.CLASS) {
                            // in a classroom
                            desirability++;
                        } else if (tile.type != TileType.STAIRS && !(tile.type == TileType.EMPTY && tile.variant == 1)) {
                            // next to a wall
                            if (neighbor.x > 0 && gridCollection.grids[int(neighbor.z)].tiles[int(neighbor.x)-1][int(neighbor.y)].type == TileType.WALL) {
                                desirability++;
                            }
                            if (neighbor.x < gridCollection.width-1 && gridCollection.grids[int(neighbor.z)].tiles[int(neighbor.x)+1][int(neighbor.y)].type == TileType.WALL) {
                                desirability++;
                            }
                            
                            if (neighbor.y > 0 && gridCollection.grids[int(neighbor.z)].tiles[int(neighbor.x)][int(neighbor.y)-1].type == TileType.WALL) {
                                desirability++;
                            }
                            if (neighbor.y < gridCollection.height-1 && gridCollection.grids[int(neighbor.z)].tiles[int(neighbor.x)][int(neighbor.y)+1].type == TileType.WALL) {
                                desirability++;
                            }

                            // cafeteria or other eating area
                            if (tile.type == TileType.EATING) {
                                desirability += 7;
                            }
                        }

                        tile.lunchDesirability = desirability;
                        totalLunchDesirability += desirability;

                        queue.add(new PathfindStep(int(neighbor.x), int(neighbor.y), int(neighbor.z)));
                    }
                }
            }

            colorMode(HSB);
            for (int i = 0; i < numberOfStudents; ++i) {
                PVector startingPos;
                // initially place students
                if (random(1) < 0.5) {
                    startingPos = new PVector(floor(random(2)) * (gridCollection.width - 1) * 10, random(gridCollection.height - 1) * 10, 0);
                } else {
                    startingPos = new PVector(random(gridCollection.width - 1) * 10, floor(random(2)) * (gridCollection.height - 1) * 10, 0);
                }
                students[i] = new Student(color(random(255), random(128, 255), random(128, 255)), startingPos, random(2.5, 4.5), random(0.075, 0.225), random(5, 25), 4.5);

                // pathfind to first class
                students[i].pathfindTo(students[i].classes[period]);
            }
            colorMode(RGB);
            break;

        // save school layout
        case ENTER:
            gridCollection.save("data/school.txt");
            break;

        // switch floors
        case CODED:
            switch(keyCode) {
                case UP:
                    gridCollection.moveUp();
                    break;
                case DOWN:
                    gridCollection.moveDown();
                    break;
            }
        
        // change selected tile type
        default:
            if (Character.isDigit(key)) {
                int index = (key - '0') - 1; // Subtracting the ASCII value of '0' by the ASCII value of the key pressed will always give the numerical value of the key

                if (index >= 0 && index < TileType.values().length) {
                    TileType tileType = TileType.values()[index];

                    if (selectedType.equals(tileType)) { // Already selected, change the variant instead
                        if (selectedType.numVariants > 1) 
                            selectedVariant = (selectedVariant + 1) % tileType.numVariants;

                    } else {
                        selectedType = tileType;
                        selectedVariant = 0;
                    }
                }
            }
            break;
    }

}

void handleMouse() {
    // Anytime the mouse is clicked or dragged or the camera moved while the mouse is being help down
    int column = floor((mouseX - cameraPos.x) / (10 * zoom));
    int row = floor((mouseY - cameraPos.y) / (10 * zoom));

    // in bounds
    if (column >= 0 && column < gridCollection.current.width && row >= 0 && row < gridCollection.current.height){

        if (selectedType == TileType.STAIRS) { // make sure there is a level that the stair block goes to, and automatically place another stair block on the other level
            if (selectedVariant == 0 && gridCollection.index != 0) {
                gridCollection.current.tiles[column][row].type = selectedType;
                gridCollection.current.tiles[column][row].variant = 0;
                gridCollection.grids[gridCollection.index - 1].tiles[column][row].type = selectedType;
                gridCollection.grids[gridCollection.index - 1].tiles[column][row].variant = 1;

            } else if (selectedVariant == 1 && gridCollection.index != gridCollection.levels - 1) {
                gridCollection.current.tiles[column][row].type = selectedType;
                gridCollection.current.tiles[column][row].variant = 1;
                gridCollection.grids[gridCollection.index + 1].tiles[column][row].type = selectedType;
                gridCollection.grids[gridCollection.index + 1].tiles[column][row].variant = 0;

            }
        } else {
            gridCollection.current.tiles[column][row].type = selectedType;
            gridCollection.current.tiles[column][row].variant = selectedVariant;
        }
    }
}

void mouseDragged() {
    handleMouse();
}
void mousePressed() {
    handleMouse();
}