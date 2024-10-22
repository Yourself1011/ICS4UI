int frame = 0;
boolean paused = false;

void setup() {
    size(512, 512);
}

void draw() {
    background(204);
    frame++;
    fill(0);
    text(frame, 256, 256);
}

void keyPressed() {
    paused = !paused;
    if (paused) {
        loop();
    } else {
        noLoop();
    }
}

void mouseClicked() {
    redraw();
}