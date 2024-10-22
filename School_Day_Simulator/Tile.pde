class Tile {
    TileType type;
    PVector pos;
    int tileSize, variant;
    float lunchDesirability = -1;

    Tile(TileType type, int variant, PVector pos, int tileSize) {
        this.type = type;
        this.variant = variant;
        this.pos = pos;
        this.tileSize = tileSize;
    }

    Tile(String data, PVector pos, int tileSize) {
        String[] split = split(data, "-");
        this.type = TileType.valueOf(split[0]);
        this.variant = int(split[1]);
        this.pos = pos;
        this.tileSize = tileSize;
    }

    void draw() {
        fill(type.colors[variant]);
        square(pos.x, pos.y, tileSize);
    }

    String save() {
        return type + "-" + variant;
    }
}

enum TileType {
    EMPTY(new color[] {#FFFFFF, #AAAAAA}, new String[] {"EMPTY", "DOOR"}), 
    WALL(new color[] {#000000, #fc8068}, new String[] {"WALL", "STAFFDOOR"}),
    STAIRS(new color[] {#BF00FF, #6A00FF}, new String[] {"DOWN", "UP"}), 
    CLASS(new color[] {#A8000E, #A89A00, #27A800, #006AA8, #A84900, #ffa033, #41e7fa, #5d7531}, new String[] {"MATH", "ENGLISH", "SCIENCE", "TECH", "HISTORY", "ART", "PHYSED", "MISC"}),
    EATING(new color[] {#7e871c}, new String[] {"EATING"}),
    OFFICE(new color[] {#9e5041}, new String[] {"OFFICE"});

    final int numVariants;
    final String[] variants;
    final color[] colors;

    private TileType(color[] colors, String[] variantNames) {
        this.colors = colors;
        this.numVariants = colors.length;
        this.variants = variantNames;
    }
}