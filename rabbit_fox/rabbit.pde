class Rabbit {
    PVector pos, vel, target;
    float speed, sight, nervousness;
    color col;

    Rabbit(PVector pos, float speed, float sight, color col, float nervousness) {
        this.pos = pos;
        this.col = col;
        this.speed = speed;
        this.sight = sight;
        this.nervousness = nervousness;
        vel = new PVector(random(-1, 1), random(-1, 1)).setMag(speed);
        target = vel;
    }

    void move() {
        vel.add(PVector.sub(target, vel).limit(0.05));
        pos.add(vel);

        if (random(0, 1) < nervousness) {
            if (random(0, 1) < nervousness) {
                if (target.mag() == 0) {
                    target = new PVector(random(-1, 1), random(-1, 1)).setMag(speed);
                } else {
                    target = new PVector(0, 0);
                }
            }

            target.rotate(radians(random(-180, 180)));
        }
    }

    void draw() {
        fill(col);
        square(pos.x - 25, pos.y - 25, 50);
        noFill();
        circle(pos.x, pos.y, sight);
    }
}