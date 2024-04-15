#include<mdc-5.h>

float broker_commision(float trade_amount)
{
  if (trade_amount < 2500.00f) {
    return 30.00f + (0.017f * trade_amount);
  } else if (trade_amount >= 2500.00f && trade_amount < 6250.00f) {
    return 56.00f + (0.0066f * trade_amount);
  } else if (trade_amount >= 6250.00f && trade_amount < 20000.00f) {
    return 76.00f + (0.0034f * trade_amount);
  } else if (trade_amount >= 20000.00f && trade_amount < 50000.00f) {
    return 100.00f + (0.0022f * trade_amount);
  } else if (trade_amount >= 50000.00f && trade_amount < 500000.00f) {
    return 155.00f + (0.0011f * trade_amount);
  } else {
    return 255.00f + (0.0009f * trade_amount);
  }
}
