// FollowBall followball = new FollowBall(256, 256, 50, #FF0000);
FollowBall[] balls = new FollowBall[5];

void setup() {
    println("hi");
    size(512, 512);
    for (int i = 0; i < 5; i++) {
        balls[i] = new FollowBall(256, 256, random(30, 70), #FF0000);
    }
}

void draw() {
    background(204);
    for (int i = 0; i < 5; i++) {
        balls[i].update(mouseX, mouseY);
    }
    // followball.update(mouseX, mouseY);
}

class Ball {
    float x, y, extent;
    color c;
    Ball(float xStart, float yStart, float extentStart, color cStart) {
        x = xStart;
        y = yStart;
        extent = extentStart;
        c = cStart;
    }
    void update() {
        fill(255, 0, 0);
        circle(x, y, extent);
    }
}

class FollowBall extends Ball {
    float speed;
    FollowBall(float x, float y, float extent, color c) {
        super(x, y, extent, c);
        speed = random(0.05);
        // println(x, y, extent);
    }
    void update(float mouseX, float mouseY) {
        // println(x, y, extent);
        x += speed*(mouseX - x);
        y += speed*(mouseY - y);
        super.update();
    }
}