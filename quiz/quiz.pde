int frame = 0;

void setup() {
    size(600, 500);
}

void draw() {
    background(255);
    fill(0, max(255 * (1 - frame / (5.0 * frameRate)), 0), 0);
    float mouseDist = sqrt(pow(mouseX - width/2, 2) + pow(mouseY - height/2, 2));

    circle(width/2, height/2, mouseDist * 2);
    frame++;
}
