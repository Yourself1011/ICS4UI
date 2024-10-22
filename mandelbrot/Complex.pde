static class Complex {
    double a, b;
    double abs = -1;

    Complex(double a, double b) {
        this.a = a;
        this.b = b;
    }

    Complex add(Complex z) {
        this.a += z.a;
        this.b += z.b;
        return this;
    }

    static Complex add(Complex z, Complex w) {
        return new Complex(z.a + w.a, z.b + w.b);
    }

    double abs() {
        // return abs(this);
        if (abs == -1) {
            return abs = Math.sqrt(this.a * this.a + this.b * this.b);
        }
        return abs;
    }

    double forceAbs() {
        // return abs = Math.sqrt(this.a * this.a + this.b * this.b);
        return Math.sqrt(this.a * this.a + this.b * this.b);
    }

    static double abs(Complex z) {
        return Math.sqrt(z.a * z.a + z.b * z.b);
    }

    Complex mult(Complex z) {
        this.a = this.a * z.a - this.b * z.b;
        this.b = this.a * z.b + this.b * z.a;
        return this;
    }

    static Complex mult(Complex z, Complex w) {
        return new Complex(z.a * w.a - z.b * w.b, z.a * w.b + z.b * w.a);
    }

    Complex sr() {
        double a = this.a, b = this.b;
        this.a = a * a - b * b;
        this.b = 2 * a * b;
        return this;
    }

    static Complex sr(Complex z) {
        return new Complex(z.a * z.a - z.b * z.b, 2*z.a*z.b);
    }

    static Complex cos(Complex z) {
        return new Complex(Math.cos(z.a) * Math.cosh(z.b), -Math.sin(z.a) * Math.sinh(z.b));
    }

    static Complex sin(Complex z) {
        return new Complex(Math.sin(z.a) * Math.cosh(z.b), Math.cos(z.a) * Math.sinh(z.b));
    }

    @Override
    String toString() {
        return a + (b >= 0 ? "+" : "") + b + "i";
    }
}