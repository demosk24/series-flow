instrument {overlay = true, name = 'CoPilot4', short_name = 'BOTTPA'}

input_group {
    "UP COLOR",
    call_color = input {default = "#00FFFF", type = input.color}
}
input_group {
    "DOWN COLOR",
    put_color = input {default = "#FF00FF", type = input.color}
}

upper_ = ((high[1] - max(open[1], close[1])) / (high[1] - low[1]))
lower_ = ((min(open[1], close[1]) - low[1]) / (high[1] - low[1]))
real_ = abs(close[1] - open[1]) * 100000;

ema20 = ema(close[1], 20);
ema50 = ema(close[1], 50);
ema100 = ema(close[1], 100);
ema200 = ema(close[1], 200);

BBperiod = 20

BBUpper18 = sma(close[1], BBperiod) + stdev(close[1], BBperiod) * 1.8
BBLower18 = sma(close[1], BBperiod) - stdev(close[1], BBperiod) * 1.8

BBUpper2 = sma(close[1], BBperiod) + stdev(close[1], BBperiod) * 2
BBLower2 = sma(close[1], BBperiod) - stdev(close[1], BBperiod) * 2

BBUpper1 = sma(close[1], BBperiod) + stdev(close[1], BBperiod) * 1
BBLower1 = sma(close[1], BBperiod) - stdev(close[1], BBperiod) * 1

BBUpper2_3 = sma(close[3], BBperiod) + stdev(close[3], BBperiod) * 2
BBLower2_3 = sma(close[3], BBperiod) - stdev(close[3], BBperiod) * 2

BBUpper1_3 = sma(close[3], BBperiod) + stdev(close[3], BBperiod) * 1
BBLower1_3 = sma(close[3], BBperiod) - stdev(close[3], BBperiod) * 1

ema_put = close[1] < ema20 and ema20 < ema50 and ema50 < ema100 and ema100 <
              ema200
ema_call = close[1] > ema20 and ema20 > ema50 and ema50 > ema100 and ema100 >
               ema200

doji = (abs(open[1] - close[1]) <= (high[1] - low[1]) * 0.2)

ms2_buy = open[3] > close[3] and close[3] > close[2] and close[3] > open[2] and
              open[1] < close[1] and open[1] > open[2] and
              abs(close[2] - open[2]) < (33 / 100 * abs(close[3] - open[3])) and
              doji == false and open[1] > ema20 and close[2] > ema20 and high(1) <
              BBUpper18

es2_sell = open[3] < close[3] and close[3] < close[2] and close[3] < open[2] and
               open[1] > close[1] and open[1] < open[2] and
               abs(close[2] + open[2]) > (33 / 100 * abs(close[3] - open[3])) and
               doji == false and open[1] < ema20 and close[2] < ema20 and low(1) >
               BBLower18

twzb1_call = high[3] > high[2] and low[3] > low[2] and open[2] > close[2] and
                 open[1] < close[1] and low[2] == low[1] and close[1] ~= low[1] and
                 (close[2] < open[2]) and (close[3] < open[3]) and low[1] <
                 BBLower2

twzt1_put = low[3] < low[2] and high[3] < high[2] and open[2] < close[2] and
                open[1] > close[1] and high[2] == high[1] and open[1] ~= high[1] and
                (close[2] > open[2]) and (close[3] > open[3]) and high[1] >
                BBUpper2

bodyLessThan20OfRange_call = abs((close[1] - open[1]) / (high[1] - low[1])) <=
                                 0.20
hammerClosesNearTheHigh_call = ((close[1] / high[1]) > 0.90 or
                                   (high[1] / close[1]) > 0.90)
hammerClosesNearTheHigh_put = ((close[1] / high[1]) < 0.90 or
                                  (high[1] / close[1]) < 0.90)

itIsAHammer1_call = (hammerClosesNearTheHigh_call and
                        bodyLess1Than20OfRange_call)

hammer1_put = itIsAHammer1_put and doji == false and close[1] == high[1] and
                  real_ < 5 and real_ > 3 and
                  (high[2] > high[1] and low[2] > low[1]) and high[3] > high[2] and
                  low[3] > low[2] and high[4] > high[3] and low[4] > low[3]

itIsAHammer1_put =
    (hammerClosesNearTheHigh_call and bodyLess1Than20OfRange_call)

hammer1_call = itIsAHammer1_call and doji == false and close[1] == low[1] and
                   real_ < 5 and real_ > 3 and
                   (low[2] < low[1] and high[2] < high[1]) and low[3] < low[2] and
                   high[3] < high[2] and low[4] < low[3] and high[4] < high[3]

minor_down = (open[4] <= close[4] and open[3] <= close[3] and open[2] >=
                 close[2] and open[1] >= close[1]) and
                 ((close[3] > BBUpper18) or (close[2] > BBUpper18) or
                     (high[2] > BBUpper18) or (high[3] > BBUpper18)) and ema_put
minor_up =
    (open[4] >= close[4] and open[3] >= close[3] and open[2] <= close[2] and
        open[1] <= close[1]) and
        ((close[3] < BBLower18) or (close[2] < BBLower18) or
            (low[2] < BBLower18) or (low[3] < BBLower18)) and ema_up

c1 = close[2] < open[2] and close[1] > open[1]
c2 = close[1] > open[2]
c3 =
    lowest(low, 3) < lowest(low, 50)[2] or lowest(low, 3) < lowest(low, 50)[3] or
        lowest(low, 3) < lowest(low, 50)[4]
buy_reversal = c1 and c2 and c3 and ema_call
c4 = close[2] > open[2] and close[1] < open[1]
c5 = close[1] < open[2]
c6 = highest(high, 3) > highest(high, 50)[2] or highest(high, 3) >
         highest(high, 50)[3] or highest(high, 3) > highest(high, 50)[4]
sell_reversal = c4 and c5 and c6 and ema_put

plot_shape(ms1_buy, 'MS2_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "MS2", call_color)
plot_shape(es1_sell, 'ES2_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "ES2", put_color)

plot_shape(twzt1_put, 'twzt1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "TWZT", put_color)
plot_shape(twzb1_call, 'twzb_1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "TWZB", call_color)

plot_shape(hammer1_put, 'hammer_1_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "HA",
           put_color)
plot_shape(hammer1_call, 'hammer_1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "HA", call_color)

plot_shape(minor_up, 'minorUp_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "MU", call_color)
plot_shape(minor_down, 'minorDown_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "MD",
           put_color)

plot_shape(buy_reversal, 'reversal_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "RC", call_color)
plot_shape(sell_reversal, 'reversal_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "RS",
           put_color)
