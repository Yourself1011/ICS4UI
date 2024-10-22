Rabbit allan = new Rabbit(new PVector(256, 256), 1, 100, color(100, 100, 60), 0.01);
Rabbit joe = new Rabbit(new PVector(256, 256), 1, 100, color(100, 100, 60), 0.1);
Rabbit george = new Rabbit(new PVector(256, 256), 1, 100, color(100, 100, 60), 0.05);
Plant[] plants = new Plant[6];

void setup() {
    size(512, 512);

    for (int i = 0; i < plants.length; i++) {
        plants[i] = new Plant(new PVector(random(0, width), random(0, height)), 20);
    }
}

void draw() {
    background(#00FF00);
    allan.move();
    allan.draw();
    joe.move();
    joe.draw();
    george.move();
    george.draw();

    for (Plant plant : plants) {
        plant.draw();
    }
}
