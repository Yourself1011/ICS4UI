import java.lang.Math;
import g4p_controls.*;

Complex[][] values;
double left = -2, right = 1, top = 1.5, bottom = -1.5;
PVector mouseStart = new PVector(0, 0), mouseEnd = new PVector(0, 0);
PImage img;
boolean change = false;
color col = color(255);

void setup() {
    size(840, 840);
    createGUI();
    values = new Complex[width][height];
    img = loadImage("shrek_wazowski.jpeg");
    // img = loadImage("hitler.jpeg");
    // img = loadImage("mr_schattman.jpeg");
    drawBg();
}

void draw() {

    // fill(0, bgAlpha);
    // rect(0, 0, width, height);
    // stroke(255);

    stroke(col);
    fill(col);

    // println(xToA(0), xToA(width), yToB(0), yToB(height));

    // change = false;
    loadPixels();

    do {
        for (int x = 0; x < width; x++) {
            double a = xToA(x);
            for (int y = 0; y < height; y++) {
                double b = yToB(y);
                Complex z = new Complex(a, b);
                Complex c = new Complex(a, b);
                Complex prevValue = values[x][y];

                if (values[x][y] == null) {
                    values[x][y] = new Complex(a, b);

                    // drawShape(x, y);
                    // change = true;

                    if (values[x][y].forceAbs() >= 2) {
                        drawShape(x, y);
                        change = true;
                    }
                } else if (pixels[y * width + x] != #FFFFFF) {
                    values[x][y].sr().add(new Complex(a, b));
                    // values[x][y] = Complex.cos(values[x][y]).add(new
                    // Complex(a, b)); values[x][y] =
                    // Complex.sin(values[x][y]).add(new Complex(a, b));

                    // drawShape(x, y);
                    // change = true;

                    if (values[x][y].forceAbs() >= 2) {
                        drawShape(x, y);
                        change = true;
                    }
                }
            }
        }
    } while (!change);

    if (mousePressed) {
        stroke(128);
        noFill();
        rect(
            mouseStart.x,
            mouseStart.y,
            mouseEnd.x - mouseStart.x,
            mouseEnd.y - mouseStart.y
        );
    }
}

double xToA(float x) {
    return (right - left) / width * x + left;
}

double yToB(float y) {
    return (bottom - top) / height * y + top;
}

void mousePressed() {
    mouseStart = new PVector(mouseX, mouseY);
    mouseEnd = new PVector(mouseX, mouseY);
}

void setMouseEnd() {
    // if (keyPressed && keyCode == SHIFT) {
    if (true) {
        float sideLength =
            max(max(mouseX - mouseStart.x, mouseY - mouseStart.y), 1);
        mouseEnd =
            new PVector(sideLength + mouseStart.x, sideLength + mouseStart.y);
    } else {
        mouseEnd = new PVector(mouseX, mouseY);
    }
}

void mouseDragged() {
    setMouseEnd();
}

void drawShape(int x, int y) {
    set(x, y, col);
}

// void drawShape(int x, float y) {
//     circle(x, y, 0.5);
// }

void drawBg() {
    image(img, 0, 0, width, height);
}

// void drawBg() {
//     fill(255);
//     rect(0, 0, width, height);
// }

void mouseReleased() {
    setMouseEnd();
    mouseStart.set((float) xToA(mouseStart.x), (float) yToB(mouseStart.y));
    mouseEnd.set((float) xToA(mouseEnd.x), (float) yToB(mouseEnd.y));

    left = mouseStart.x;
    right = mouseEnd.x;
    top = mouseStart.y;
    bottom = mouseEnd.y;

    values = new Complex[width][height];
    change = false;
    drawBg();
}

void keyPressed() {
    if (key == 'r') {
        reset();
    } else if (key == ' ') {
        redrawFrame();
    }
}

void redrawFrame() {
    values = new Complex[width][height];
    change = false;
    drawBg();
}

void reset() {
    left = -2;
    right = 1;
    top = 1.5;
    bottom = -1.5;
    values = new Complex[width][height];
    change = false;
    drawBg();
}
