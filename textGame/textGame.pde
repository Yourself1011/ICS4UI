ArrayList<TextItem> textItems = new ArrayList<TextItem>();
String[] words = {"hello", "world", "the", "quick", "brown", "fox", "jumped", "over", "the", "lazy", "dog", "among", "us", "processing", "is", "awesome", "and", "better", "than", "python", "help", "cannot", "think", "of", "more", "words", "suspicious", "computer", "science", "class", "is", "pretty", "cool", "int", "boolean", "string", "array", "void", "float", "for", "if", "while", "else", "public", "private", "dictionary", "object", "hashmap", "list", "pointer", "variable", "monkey", "programming", "is", "fun", "hooray", "angry", "donald", "saxophone", "british", "fish", "quite", "stupid", "innit", "git", "init", "setup", "draw", "recursion"};
int index = 0;
int wait = 0;
int score = 0;
int frame = 0;
int letters = 0;
int wrong = 0;
boolean dead = false;

void setup() {
    size(512, 512);
}

void draw() {
    background(255);

    if (wait <= 0){
        textItems.add(new TextItem(words[int(random(0, words.length))], random(50, width - 50)));
        wait = int(random(max(60 - frame * 0.01, 10), max(150 - frame * 0.01, 15)));
    }

    for (TextItem textItem: textItems) {
        textItem.update();
    }

    fill(0, 255, 0);
    if (textItems.size() > 0 && index - 1 >= 0) {
        TextItem activeItem = textItems.get(0);
        text(activeItem.text.substring(0, index), activeItem.x - textWidth(activeItem.text.substring(index)) / 2, activeItem.y);
    }

    fill(0);
    textAlign(RIGHT, TOP);
    textSize(24);
    text(score + "\n" + nf(100 - (float(wrong) / max(letters, 1)) * 100, 0, 2) + "%", width - 5, 5);
    wait--;
    frame++;
}

class TextItem {
    String text;
    float x, y = 0;

    TextItem(String t, float initX) {
        text = t;
        x = initX;
    }

    public void update() {
        y += min(2.5, 2 + frame * 0.001);
        textAlign(CENTER);
        
        if (y >= height) {
            noLoop();
            dead = true;
            textSize(32);
            fill(#FF1111);
            text("You lose", width/2, height/2);
        }

        fill(0);
        textSize(24);
        text(text, x, y);
    }
}

void keyTyped() {
    if (textItems.size() > 0 && !dead){
        letters++;
        if (key == textItems.get(0).text.charAt(index)) {
            index++;
            if (index == textItems.get(0).text.length()) {
                textItems.remove(0);
                index = 0;
                score++;
            }
        } else {
            wrong++;
            for (TextItem textItem: textItems) {
                textItem.y += 10;
                wait = int(wait / 2);
            }
        }
    }
}