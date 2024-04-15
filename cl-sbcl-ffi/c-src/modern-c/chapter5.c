#include<mdc-5.h>

float broker_commision(float trade_amount)
{
  if (trade_amount < 2500) {
    return 30 + (0.017 * trade_amount);
  } else if (trade_amount >= 2500 && trade_amount < 6250) {
    return 56 + (0.0066 * trade_amount);
  } else if (trade_amount >= 6250 && trade_amount < 20000) {
    return 76 + (0.0034 * trade_amount);
  } else if (trade_amount >= 20000 && trade_amount < 50000) {
    return 100 + (0.0022 * trade_amount);
  } else if (trade_amount >= 50000 && trade_amount < 500000) {
    return 155 + (0.0011 * trade_amount);
  } else {
    return 255 + (0.0009 * trade_amount);
  }
}
