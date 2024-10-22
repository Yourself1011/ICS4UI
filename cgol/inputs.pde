void mousePressed() {
    int x = floor((mouseX - padding) / size);
    int y = floor((mouseY - padding) / size);

    grid[x][y].alive = !grid[x][y].alive;
}

void keyPressed() {
    if (key == ' ') {
        paused = !paused;
    }
}

void mouseWheel(MouseEvent e) {
    
}