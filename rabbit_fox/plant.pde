class Plant {
    PVector pos;
    float size;
    Plant (PVector pos, float size) {
        this.pos = pos;
        this.size = size;
    }

    void draw() {
        fill(#11FF11);
        circle(pos.x, pos.y, size);
    }
}
