class Student {
    color col;
    PVector pos, vel = new PVector(0, 0), acc = new PVector(0, 0), target, startingPos, lunchSpot;
    float speed, turnSpeed, shyness, radius;
    ArrayList<PVector> path = new ArrayList<PVector>();
    int lastPathProgress = 0, stairCooldown = -30;
    boolean onProperty = true;
    PVector[] classes = new PVector[4];

    Student(color col, PVector startingPos, float speed, float turnSpeed, float shyness, float radius) {
        this.col = col;
        this.pos = startingPos;
        this.startingPos = new PVector(floor(startingPos.x / 10) * 10, floor(startingPos.y / 10) * 10, 0);
        this.speed = speed;
        this.turnSpeed = turnSpeed;
        this.shyness = shyness;
        this.radius = radius;

        chooseCourses();
        chooseLunchSpot();
    }

    private void chooseLunchSpot() {
        float choice = random(totalLunchDesirability);

        for (int i = 0; i < gridCollection.levels; i++) {
            for (Tile[] column : gridCollection.grids[i].tiles) {
                for (Tile tile : column) {
                    if (tile.lunchDesirability > 0) {
                        choice -= tile.lunchDesirability;
                        
                        if (choice <= 0) {
                            lunchSpot = new PVector(tile.pos.x, tile.pos.y, i);
                            return;
                        }
                    }
                }
            }
        }
        lunchSpot = startingPos.copy();
    }

    private void chooseCourses() {
        float rand;
        float weightSum;
        for (int i = 0; i < 4; ++i) {
            weightSum = 0.015625; // chance of spare
            ArrayList<Course> filteredCourses = new ArrayList<Course>(courses);
            
            for (Course course : courses) {
                if (course.positions.isEmpty()) {
                    filteredCourses.remove(course);
                } else {
                    weightSum += course.getWeight();
                }
            }

            if (filteredCourses.isEmpty()) {
                println("How do you expect to run a school with no classrooms?");
            }
            rand = random(0, weightSum);

            for (Course course : filteredCourses) {
                rand -= course.getWeight();

                if (rand <= 0) {
                    classes[i] = course.positions.get(floor(random(0, course.positions.size()))).copy();
                    course.choose();
                    break;
                }
            }

            if (rand > 0) {
                classes[i] = startingPos.copy();
            }
        }

        for (Course course : courses) {
            course.reset();
        }
    }

    void draw() {
        PVector target = path.get(0);
        if (path.size() == 1 && (period == 5 || target.x == 5 || target.x == (gridCollection.width - 1) * 10 + 5 || target.y == 5 || target.y == (gridCollection.height - 1) * 10 + 5)) {
            onProperty = false;
        } else {
            move();
            if (pos.z == gridCollection.index) {
                fill(col);
                circle(pos.x, pos.y, radius * 2);
            }
        }
    }

    void move() {
        if (path.size() == 1 || (path.size() != 0 && path.get(1).z != pos.z)) {
            acc.add(PVector.sub(path.get(0), pos));
        } else if (path.size() > 1) {
            acc.add(PVector.sub(path.get(1), pos));

            if (pos.dist(path.get(0)) > pos.dist(path.get(1))) {
                path.remove(0);
                lastPathProgress = frameCount;
            }
        }

        if (path.size() > 1 && frameCount - lastPathProgress > 90) {
            path = pathfindTo(target); //re-pathfind in case stuck
        }

        // go up stairs
        Tile posTile = gridCollection.grids[int(pos.z)].tiles[int(pos.x / 10)][int(pos.y / 10)];
        if (posTile.type == TileType.STAIRS/* && path.size() != 1 && (path.size() == 0 || path.get(1).z != pos.z)*/) {
            if (frameCount - stairCooldown > 30) {
                stairCooldown = frameCount; // only allow going through stairs if student has moved to a different tile type or the cooldown has passed
                if (posTile.variant == 0) {
                    pos.z--;
                } else {
                    pos.z++;
                }
            }
        } else {
            stairCooldown = -30;
        }

        // stay away from other students
        PVector shyVector = new PVector(0, 0);
        int i = 0;
        for (Student student : students) {
            // println(pos.dist(student.pos), student.pos);
            if (student.pos.z == pos.z && student.onProperty && !pos.equals(student.pos)) {
                shyVector.add(PVector.sub(pos, student.pos).mult(shyness / max(pow(pos.dist(student.pos) - radius * 2, 2), 0)));
                i++;
            }
        }
        // if (i > 0) shyVector.div(i);
        acc.add(shyVector);

        acc.mult(turnSpeed);
        vel.add(acc).limit(speed);

        PVector nextPos = pos.copy().add(vel);
        PVector edgePos = new PVector(nextPos.x + (vel.x < 0 ? -radius : radius), nextPos.y + (vel.y < 0 ? -radius : radius));
        boolean hitWall = false;

        // check going to hit wall
        // Going in the x direction will make it hit a wall
        if (edgePos.x < 0 || edgePos.x >= gridCollection.width * 10 || gridCollection.grids[floor(pos.z)].tiles[floor(edgePos.x / 10)][floor(pos.y / 10)].type == TileType.WALL) {
            vel.x = vel.x > 0 ? -0.25 : 0.25;
            vel.y += vel.y < 0 ? -0.25 : 0.25; //"bounce" it off the wall a little so it doesn't get stuck
            hitWall = true;
        }
        // Going in the y direction will make it hit a wall
        if (edgePos.y < 0 || edgePos.y >= gridCollection.height * 10 || gridCollection.grids[floor(pos.z)].tiles[floor(pos.x / 10)][floor(edgePos.y / 10)].type == TileType.WALL) {
            vel.y = vel.y > 0 ? -0.25 : 0.25;
            vel.x += vel.x < 0 ? -0.25 : 0.25;
            hitWall = true;
        }

        // Going in the both directions will make it hit a wall
        if (!hitWall && edgePos.x > 0 && edgePos.x < gridCollection.width * 10 && edgePos.y > 0 && edgePos.y < gridCollection.height && gridCollection.grids[floor(pos.z)].tiles[floor(edgePos.x / 10)][floor(edgePos.y / 10)].type == TileType.WALL) {
            vel.setMag(-1);
        }

        pos.x += vel.x;
        pos.y += vel.y;

        acc = new PVector(0, 0);
    }

    ArrayList<PVector> pathfindTo(PVector target) {
        onProperty = true;
        this.target = target.copy();
        target = target.copy();
        int[][][] distanceMatrix = new int[gridCollection.levels][gridCollection.width][gridCollection.height];

        for (int floor = 0; floor < gridCollection.levels; ++floor) {
            for (int column = 0; column < gridCollection.width; ++column) {
                for (int row = 0; row < gridCollection.height; ++row) {
                    distanceMatrix[floor][column][row] = Integer.MAX_VALUE;
                }
            }
        }

        PVector posGrid = new PVector(floor(pos.x / 10), floor(pos.y / 10), pos.z);
        PathfindStep currentTile = new PathfindStep(int(posGrid.x), int(posGrid.y), int(posGrid.z), 0);

        target.z *= 10;
        target.div(10); // We want the grid coordinates instead of the position on map coordinates
        boolean foundTarget = false;
        ArrayList<PathfindStep> queue = new ArrayList<PathfindStep>();
        queue.add(currentTile);
        distanceMatrix[currentTile.level][currentTile.x][currentTile.y] = 0;

        while (!queue.isEmpty() && !foundTarget) {
            // A variant of Dijkstra's algorithm which is simplified by the fact that every edge has a weight of 1
            PathfindStep currentStep = queue.remove(0);
            // println("Searching", currentStep.level, currentStep.x, currentStep.y);

            for (PVector neighbor : currentStep.getValidNeighbors(distanceMatrix)) {
                distanceMatrix[int(neighbor.z)][int(neighbor.x)][int(neighbor.y)] = currentStep.dist + 1;
                if (neighbor.equals(target)) {
                    // println("Found target");
                    foundTarget = true;
                    break;
                }

                queue.add(new PathfindStep(int(neighbor.x), int(neighbor.y), int(neighbor.z), currentStep.dist + 1));
            }
        }

        ArrayList<PVector> path = new ArrayList<PVector>();
        target.z /= 10;
        path.add(target.copy().mult(10));
        target.z *= 10;
        PathfindStep current = new PathfindStep(int(target.x), int(target.y), int(target.z), distanceMatrix[int(target.z)][int(target.x)][int(target.y)]);

        // println(current.dist);
        // for (int[] column : distanceMatrix[2]) {
        //     for (int thing : column) {
        //         print((thing == Integer.MAX_VALUE ? "i" : thing) + " ");
        //     }
        //     println();
        // }

        boolean foundStart = false;
        boolean hasNeighbors = true;

        while (foundTarget && !foundStart && hasNeighbors) {
            hasNeighbors = false;
            for (PVector neighbor : current.getValidNeighbors()) {
                if (distanceMatrix[int(neighbor.z)][int(neighbor.x)][int(neighbor.y)] < current.dist) {
                    hasNeighbors = true;
                    if (neighbor.equals(posGrid)) {
                        // println("Found start");
                        foundStart = true;
                        break;
                    }

                    current = new PathfindStep(int(neighbor.x), int(neighbor.y), int(neighbor.z), distanceMatrix[int(neighbor.z)][int(neighbor.x)][int(neighbor.y)]);
                    // println(neighbor);
                    neighbor.z /= 10;
                    path.add(neighbor.mult(10));
                    break;
                }
            }
        }

        lastPathProgress = frameCount;

        for (PVector item : path) {
            item.add(new PVector(5, 5));
        }

        Collections.reverse(path);
        this.path = path;
        return path;
    }
}