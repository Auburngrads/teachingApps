#include "heads/base.h"

double dsign(double x, double c) {

  return fabs(x) * R::sign(c);
}
