instrument {overlay = true, name = 'CoPilot3', short_name = 'BOTTPA'}

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

dc2_sell = open[1] > close[1] and close[1] > open[2] and close[1] < close[2] and
               close[2] > open[2] and close[3] > open[3] and close[4] > open[4] and
               ((close[2] + open[2]) / 2) > close[1] and doji == false and
               ema_put and close[1] > BBUpper1
pl2_buy = open[1] < close[2] and close[1] > close[2] and close[1] < open[2] and
              close[2] < open[2] and close[3] < open[3] and close[4] < open[4] and
              ((open[2] + close[2]) / 2) < close[1] and doji == false and
              ema_call and close[1] > BBLower1 and close[1] < BBUpper1

dc1_sell = open[1] > close[1] and close[1] > open[2] and close[1] < close[2] and
               close[2] > open[2] and close[3] > open[3] and close[4] > open[4] and
               ((close[2] + open[2]) / 2) > close[1] and doji == false and
               ema_call and close[1] > BBUpper1
pl1_buy = open[1] < close[2] and close[1] > close[2] and close[1] < open[2] and
              close[2] < open[2] and close[3] < open[3] and close[4] < open[4] and
              ((open[2] + close[2]) / 2) < close[1] and doji == false and
              ema_put and close[1] < BBLower1

huge_candle3_buy =
    close[3] < open[3] and (abs(close[2] - open[2]) * 100000) < 2 and real_ > 40 and
        close[4] > open[4] and abs(open[1] - close[1]) > abs(open[2] - close[2]) and
        open[1] < BBLower1 and close[1] > BBLower1 and close[1] < ema20

huge_candle3_sell = close[3] > open[3] and (abs(close[2] - open[2]) * 100000) <
                        2 and real_ > 40 and close[4] < open[4] and
                        abs(open[1] - close[1]) > abs(open[2] - close[2]) and
                        open[1] > BBUpper1 and close[1] < B1BUpper1 and close[1] >
                        ema20

huge_candle2_buy =
    close[3] < open[3] and (abs(close[2] - open[2]) * 100000) < 3 and real_ > 40 and
        close[1] < ema20 and close[4] > open[4] and abs(open[1] - close[1]) >
        abs(open[2] - close[2])

huge_candle2_sell = close[3] > open[3] and (abs(close[2] - open[2]) * 100000) <
                        3 and real_ > 40 and close[1] > ema20 and close[4] <
                        open[4] and abs(open[1] - close[1]) >
                        abs(open[2] - close[2])

huge_candle1_sell = close[1] > BBUpper2 and close[1] > open[1] and close[2] >
                        open[2] and real_ > 50 and abs(open[1] - close[1]) >
                        abs(open[2] - close[2])

huge_candle1_buy = close[1] < BBLower2 and close[1] < open[1] and close[2] <
                       open[2] and real_ > 50 and abs(open[1] - close[1]) >
                       abs(open[2] - close[2]) and current_bar_id ~= 212

tws4_sell = open[4] > close[4] and open[3] < close[3] and open[2] < close[2] and
                open[1] < close[1] and close[3] < close[2] and close[2] <
                close[1] and close[2] - open[2] > close[3] - open[3] and doji ==
                false and not ema_call and not ema_put and close[1] < BBUpper1 and
                close[1] > ema20 and abs(open[3] - close[3]) >
                abs(open[2] - close[2]) and abs(open[2] - close[2]) >
                abs(open[1] - close[1])

tbc4_buy = open[4] < close[4] and open[3] > close[3] and open[2] > close[2] and
               open[1] > close[1] and close[3] > close[2] and close[2] >
               close[1] and close[2] - open[2] > close[3] - open[3] and doji ==
               false and not ema_call and not ema_put and close[1] > BBLower1 and
               abs(open[3] - close[3]) > abs(open[2] - close[2]) and
               abs(open[2] - close[2]) > abs(open[1] - close[1])

tws3_sell = open[4] > close[4] and open[3] < close[3] and open[2] < close[2] and
                open[1] < close[1] and close[3] < close[2] and close[2] <
                close[1] and close[2] - open[2] > close[3] - open[3] and doji ==
                false and not ema_call and not ema_put and close[1] > BBUpper2

tbc3_buy = open[4] < close[4] and open[3] > close[3] and open[2] > close[2] and
               open[1] > close[1] and close[3] > close[2] and close[2] >
               close[1] and close[2] - open[2] > close[3] - open[3] and doji ==
               false and not ema_call and not ema_put and close[1] < BBLower2

tws2_sell = open[4] > close[4] and open[3] < close[3] and open[2] < close[2] and
                open[1] < close[1] and close[3] < close[2] and close[2] <
                close[1] and close[2] - open[2] > close[3] - open[3] and doji ==
                false and ema_call and close[1] > BBUpper18

tbc2_buy = open[4] < close[4] and open[3] > close[3] and open[2] > close[2] and
               open[1] > close[1] and close[3] > close[2] and close[2] >
               close[1] and close[2] - open[2] > close[3] - open[3] and doji ==
               false and ema_put and close[1] < BBLower18

tws1_sell = open[4] > close[4] and open[3] < close[3] and open[2] < close[2] and
                open[1] < close[1] and close[3] < close[2] and close[2] <
                close[1] and close[2] - open[2] > close[3] - open[3] and doji ==
                false and ema_put

tbc1_buy = open[4] < close[4] and open[3] > close[3] and open[2] > close[2] and
               open[1] > close[1] and close[3] > close[2] and close[2] >
               close[1] and close[2] - open[2] > close[3] - open[3] and doji ==
               false and ema_call

ms1_buy = open[3] > close[3] and close[3] > close[2] and close[3] > open[2] and
              open[1] < close[1] and open[1] > open[2] and
              abs(close[2] - open[2]) < (33 / 100 * abs(close[3] - open[3])) and
              close[1] > open[3] and doji == false and open[1] > ema20 and
              close[2] > ema20 and high(1) < BBUpper18
es1_sell = open[3] < close[3] and close[3] < close[2] and close[3] < open[2] and
               open[1] > close[1] and open[1] < open[2] and
               abs(close[2] + open[2]) > (33 / 100 * abs(close[3] - open[3])) and
               close[1] < open[3] and doji == false and open[1] < ema20 and
               close[2] < ema20 and low[1] > BBLower18

plot_shape(ms1_buy, 'MS1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "MS1", call_color)
plot_shape(es1_sell, 'ES1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "ES1", put_color)

plot_shape(tbc1_buy, '3BC1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "3BC1", call_color)
plot_shape(tws1_sell, '3WS1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "3WS", put_color)

plot_shape(tbc2_buy, '3BC2_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "3BC2", call_color)
plot_shape(tws2_sell, '3WS2_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "3WS2", put_color)
plot_shape(tbc3_buy, '3BC3_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "3BC3", call_color)
plot_shape(tws3_sell, '3WS3_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "3WS3", put_color)
plot_shape(tbc4_buy, '4BC4_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "3BC4", call_color)
plot_shape(tws4_sell, '4WS4_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "3WS4", put_color)

plot_shape(huge_candle1_buy, 'huge_candle1_BUY', shape_style.arrowup,
           shape_size.large, 'transparent', shape_location.belowbar, 0, "HC1",
           call_color)
plot_shape(huge_candle1_sell, 'huge_candle1_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "HC1",
           put_color)

plot_shape(huge_candle2_buy, 'huge_candle2_BUY', shape_style.arrowup,
           shape_size.large, 'transparent', shape_location.belowbar, 0, "HC2",
           call_color)
plot_shape(huge_candle2_sell, 'huge_candle2_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "HC2",
           put_color)

plot_shape(huge_candle3_buy, 'huge_candle3_BUY', shape_style.arrowup,
           shape_size.large, 'transparent', shape_location.belowbar, 0, "HC3",
           call_color)
plot_shape(huge_candle3_sell, 'huge_candle3_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "HC3",
           put_color)

plot_shape(pl1_buy, 'PL1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "PL1", call_color)
plot_shape(dc1_sell, 'DC1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "DC1", put_color)

plot_shape(pl2_buy, 'PL2_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "PL2", call_color)
plot_shape(dc2_sell, 'DC2_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "DC2", put_color)
