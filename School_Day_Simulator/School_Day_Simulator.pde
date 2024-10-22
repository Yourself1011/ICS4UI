import java.util.*;

BufferedReader reader;
GridCollection gridCollection;
PVector cameraPos = new PVector(0, 0);
float zoom = 1;
TileType selectedType = TileType.WALL;
int selectedVariant = 0;
int period = 0, totalMinutes = 0;
float minutesPerSecond = 2;
Student[] students;
boolean started = false;
boolean path = false;
float totalLunchDesirability;
ArrayList<Course> courses = new ArrayList<Course>();

// Settings
int numberOfStudents = 360;

void setup() {
    fullScreen();

    try {
        reader = createReader("data/courses.txt");
        String line;
        String[] data;
        String[] probabilities;
        float[] floatProbabilities;

        while ((line = reader.readLine()) != null) {
            data = split(line, ":");
            probabilities = split(data[1], ",");
            floatProbabilities = new float[probabilities.length];

            for (int i = 0; i < probabilities.length; i++) {
                floatProbabilities[i] = float(probabilities[i]);
            }
            courses.add(new Course(data[0], floatProbabilities));
        }
    } catch (Exception e) {
        println(e);
        println("Error in the courses.txt file, perhaps it is corrupted?");
        exit();
    }

    try {
        reader = createReader("data/school.txt");
        gridCollection = new GridCollection();
    } catch (Exception e) {
        println(e);
        println("Could not find school (school.txt may be corrupted or not found), generating a new one");
        gridCollection = new GridCollection(3, int(width / 10), int(height / 10));
    }

    students = new Student[numberOfStudents];

    ellipseMode(CENTER);
}

void draw() {
    background(255);

    // Transform stuff
    translate(cameraPos.x, cameraPos.y);
    scale(zoom);

    // Draw grid lines
    strokeWeight(1);
    stroke(0);
    gridCollection.current.draw();

    // Mouse preview
    if (frameCount / 10 % 2 == 0) {
        float x = floor((mouseX - cameraPos.x) / (10 * zoom)) * 10;
        float y = floor((mouseY - cameraPos.y) / (10 * zoom)) * 10;

        if (x >= 0 && x < gridCollection.current.width * 10 && y >= 0 && y < gridCollection.current.height * 10) {
            fill(selectedType.colors[selectedVariant]);
            square(x, y, 10);
        }
    }

    if (started) {
        // draw path
        if (path) {
            stroke(color(255, 0, 0, 128));
            strokeWeight(3);
            noFill();
            for (Student student : students) {
                beginShape();
                for (PVector tile : student.path) {
                    if (tile.z == gridCollection.index) {
                        vertex(tile.x, tile.y);
                    } else {
                        endShape();
                        beginShape();
                    }
                }
                endShape();
            }
        }

        stroke(0);
        strokeWeight(1);
        // draw students
        for (Student student : students) {
            student.draw();
        }
    }


    // Undo transformations for UI elements
    scale(1/zoom);
    translate(-cameraPos.x, -cameraPos.y);

    fill(126);
    textAlign(LEFT, TOP);
    textSize(64);
    text("Floor " + (gridCollection.index + 1), 20, 20);

    textAlign(RIGHT, TOP);
    textSize(32);
    text(selectedType + " - " + selectedType.variants[selectedVariant], width - 20, 20);

    if (started) {
        // Time logic
        boolean pm = totalMinutes > 720;
        int minutes = totalMinutes % 60;
        int hours = totalMinutes / 60 - (totalMinutes >= 780 ? 12 : 0);

        text(hours + ":" + nf(minutes, 2) + (pm ? "pm" : "am"), width - 20, 60);
        if (frameCount % round(30 / minutesPerSecond) == 0) {
            totalMinutes++;
            if (totalMinutes == 500 || totalMinutes == 580 || totalMinutes == 715 || totalMinutes == 795) { //period start times
                minutesPerSecond = 2.25;
            } else if (totalMinutes == 575 || totalMinutes == 710 || totalMinutes == 790) {
                minutesPerSecond = 0.125;
                period++;

                for (Student student : students) {
                    student.pathfindTo(student.classes[period]);
                }
            } else if (totalMinutes == 870) {
                minutesPerSecond = 2;
                for (Student student : students) {
                    student.pathfindTo(student.startingPos);
                }
            } else if (totalMinutes == 655) {
                minutesPerSecond = 1;
                for (Student student : students) {
                    student.pathfindTo(student.lunchSpot);
                }
            } else if (totalMinutes == 960) {
                period = 0;
                totalMinutes = 485;
                minutesPerSecond = 0.5;
                for (Student student : students) {
                    student.pathfindTo(student.classes[period]);
                }
            }
        }
    }
}
