String request = "Draw a blue square with centre (123, 456) and diameter 200";
float xC, yC, d;
String shape;
int col;

void setup() {
    size(512, 512);
    xC = float(request.substring(request.indexOf(" (") + 2, request.indexOf(", ")));
    yC = float(request.substring(request.indexOf(", ") + 2, request.indexOf(")")));
    d = float(request.substring(request.indexOf("diameter") + 8));
    shape = match(request, "(?<= )[A-z]*(?= with)")[0];

    switch (match(request, "(?<=a )[A-z]*(?= )")[0]) {
        case ("red"):
            col = #FF0000;
            break;
        case ("green"):
            col = #00FF00;
            break;
        case ("blue"):
            col = #0000FF;
            break;
        case ("black"):
            col = #000000;
            break;
    }

    println(xC, yC, d, col);
}

void draw() {
    fill(col);
    switch (shape) {
        case ("circle"):
            circle(xC, yC, d);
            break;
        case ("square"):
            square(xC - d/2, yC - d/2, d);
            break;
        // case ("triangle"):
        //     triangle(x1, y1, x2, y2, x3, y3);
    }
}
