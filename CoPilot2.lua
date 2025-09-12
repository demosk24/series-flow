instrument {overlay = true, name = 'CoPilot2', short_name = 'BOTTPA'}

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

hangingman_put =
    real_ < 6 and (lower_ * 3 > abs(close[1] - open[1])) and doji == false and
        high[1] == close[1] and ema_call and high[1] > BBUpper2 and high[2] ~=
        close[1] and high[3] < high[1]

bullish_harami_call = (open[2] > close[2] and close[1] > open[1] and close[1] <=
                          open[2] and close[2] <= open[1] and close[1] - open[1] <
                          open[2] - close[2]) and doji == false and ema_call and
                          real_ < 1 and close[1] < BBLower1

bearish_harami_put = (close[2] > open[2] and open[1] > close[1] and open[1] <=
                         close[2] and open[2] <= close[1] and open[1] - close[1] <
                         close[2] - open[2]) and doji == false and ema_put and
                         real_ < 1 and close[1] > BBUpper1

hhhl1_buy =
    high[1] < BBUpper18 and close[1] > close[2] and open[1] > open[2] and
        open[2] < close[2] and open[1] < close[1] and close[2] < open[3] and
        close[1] > high[2] and close[1] ~= high[1] and close[1] ~= high[2] and
        close[1] ~= high[3] and close[1] ~= high[4] and real_ > 5 and ema_call and
        ema_call and doji == false

lllh1_sell =
    close[1] > low[2] and low[1] > BBLower18 and close[1] < close[2] and open[1] <
        open[2] and open[2] > close[2] and open[1] > close[1] and close[2] >
        open[3] and close[1] < low[2] and close[1] ~= low[1] and close[1] ~=
        low[2] and close[1] ~= low[3] and close[1] ~= low[4] and real_ > 5 and
        ema_put and ema_put and doji == false

poe2_buy = low[2] == close[1] and open[1] > close[1] and doji == false and
               not ema_call and not ema_put and low[1] == close[1] and close[1] <
               BBUpper2 and real_ > 2 and close[1] > ema20

poe2_sell = high[2] == close[1] and open[1] < close[1] and doji == false and
                not ema_put and not ema_call and high[1] == close[1] and
                close[1] > BBLower2 and real_ > 2 and close[1] > ema20

poe1_buy = low[2] == close[1] and open[1] > close[1] and doji == false and
               ema_call and close[1] < BBUpper2
poe1_sell = high[2] == close[1] and open[1] < close[1] and doji == false and
                ema_put and close[1] > BBLower2

eng4_buy = high[1] < BBUpper2 and close[2] < open[2] and open[1] < close[1] and
               close[1] > open[2] and doji == false and close[1] > high[3] and
               close[1] > high[2] and close[1] > ema20 and close[2] < ema20 and
               open[1] < ema20 and ema200 < ema100 and ema100 < ema50 and ema50 <
               ema20 and close[1] > high[2] and close[1] > high[3] and close[3] <
               open[3] and close[4] < open[4] and close[5] > open[5]

eng4_sell = low[1] > BBLower2 and close[2] > open[2] and open[1] > close[1] and
                close[1] < open[2] and doji == false and close[1] < low[3] and
                close[1] < low[2] and close[1] < ema20 and close[2] > ema20 and
                open[1] > ema20 and ema200 > ema100 and ema100 > ema50 and ema50 >
                ema20 and close[1] < low[2] and close[1] < low[3] and close[3] >
                open[3] and close[4] > open[4] and close[5] < open[5]

eng8_buy = open[2] > close[2] and doji == false and close[1] < BBLower1 and
               open[2] < BBLower1 and not ema_put and close[1] > high[2] and
               close[1] > high[3] and close[3] < open[3] and close[4] < open[4] and
               close[5] < open[5]

eng8_sell = open[2] < close[2] and doji == false and close[1] > BBUpper1 and
                open[2] > BBUpper1 and not ema_call and close[1] < low[2] and
                close[1] < low[3] and close[3] > open[3] and close[4] > open[4] and
                close[5] > open[5]

eng3_buy = open[2] > close[2] and doji == false and close[1] < BBLower1 and
               open[2] < BBLower1 and not ema_call and close[1] > high[2] and
               close[1] > high[3] and close[3] < open[3] and close[4] < open[4] and
               close[5] < open[5]

eng3_sell = open[2] < close[2] and doji == false and close[1] > BBUpper1 and
                open[2] > BBUpper1 and not ema_put and close[1] < low[2] and
                close[1] < low[3] and close[3] > open[3] and close[4] > open[4] and
                close[5] > open[5]

eng2_buy = open[2] < close[1] and doji == false and close[3] < BBLower1 and
               open[1] < BBLower1 and close[1] < BBLower1 and
               (close[1] > high[2] * 1.3) and (close[1] > high[3] * 1.3) and
               ema_call

eng2_sell = open[2] < close[2] and open[2] > close[1] and doji == false and
                close[2] > BBUpper1 and open[1] > BBUpper1 and close[1] <
                BBUpper1 and (close[1] < low[2] * 1.3) and
                (close[1] < low[3] * 1.3) and ema_put

eng1_buy = open[2] > close[2] and close[1] > open[1] and close[1] >= open[2] and
               close[2] >= open[1] and close[1] - open[1] > open[2] - close[2] and
               doji == false and ema_call and close[1] > high[2] and close[3] <
               open[3] and close[4] < open[4]

eng1_sell =
    close[2] > open[2] and open[1] > close[1] and open[1] >= close[2] and
        open[2] >= close[1] and open[1] - close[1] > close[2] - open[2] and doji ==
        false and ema_put and close[1] < low[2] and close[3] > open[3] and
        close[4] > open[4] and close[5] > open[5]

plot_shape(hangingman_put, 'hangingman_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "HM",
           put_color)

plot_shape(bullish_harami_call, 'bullish_harami_BUY', shape_style.arrowup,
           shape_size.large, 'transparent', shape_location.belowbar, 0, "HAR",
           call_color)
plot_shape(bearish_harami_put, 'bearish_harami_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "HAR",
           put_color)

plot_shape(lllh1_sell, 'lllh_1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "LL", put_color)

plot_shape(hhhl1_buy, 'hhhl_1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "HH", call_color)

plot_shape(poe1_buy, 'PoE1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "POE1", call_color)
plot_shape(poe1_sell, 'PoE1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "POE1", put_color)

plot_shape(poe2_buy, 'PoE2_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "POE2", call_color)
plot_shape(poe2_sell, 'PoE2_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "POE2", put_color)

plot_shape(eng4_buy, 'eng4_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "Eng4", call_color)
plot_shape(eng4_sell, 'eng4_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "Eng4", put_color)

plot_shape(eng8_buy, 'eng8_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "Eng8", call_color)
plot_shape(eng8_sell, 'eng8_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "Eng8", put_color)

plot_shape(eng3_buy, 'eng3_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "Eng3", call_color)
plot_shape(eng3_sell, 'eng3_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "Eng3", put_color)

plot_shape(eng2_buy, 'eng2_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "Eng2", call_color)
plot_shape(eng2_sell, 'eng2_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "Eng2", put_color)

plot_shape(eng1_buy, 'eng1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "Eng1", call_color)
plot_shape(eng1_sell, 'eng1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "Eng1", put_color)
