float billAmt = random(30, 100);
int numCustomers = 12;
String custName = "joe biden";
float hst, total;

void setup() {
    if (numCustomers > 15) {
        println("too fat/too many people");
    } else if (numCustomers <= 0) {
        println("bozo");
    } else {
        hst = 0.13 * billAmt;
        total = (hst + billAmt) * numCustomers;
        String printedTotal = nf(total, 0, 2);
        println("ok nerd, $" + printedTotal);
    }
}

void draw() {
    
}
