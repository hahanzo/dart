import 'dart:math';

void main() {
  int option = 2;
  double x = 1.23 * option;
  double y = 4.6 * option;
  double z = 33.6 / option;

  Function ft = outer(x, y, z);

  for (int i = 0; i < 10; i++) {
    ft();
  }
}

Function outer(double x, double y, double z) {
  Function b = (double x, double y, double z) {
    return (2 * z + cos(pow((y - 3 * x).abs(), 1 / 3))) /
        (2.1 + pow(sin((pow(z, 3) - y).abs()), 2));
  };

  return () {
    double a =
        pow(x.abs(), 0.43) +
        (sqrt(pow((y * y + b(x, y, z)).abs(), 0.22))) /
            (1 + x * x * (y - pow(tan(z), 2)).abs());

    print("x=$x y=$y z=$z a=$a");
    x++;
  };
}