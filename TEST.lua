instrument {overlay = true, name = 'CoPilotXXX', short_name = 'BOTTPA'}

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

gapUp_put = low[1] < high[2] and low[1] < low[2] and high[1] < high[2] and
                open[1] ~= close[1] and abs(open[1] - close[2]) >
                abs(open[2] - close[2]) and doji ~= false and close[1] <
                BBUpper2 and lower_ < upper_

gapDown_call = low[1] > high[2] and low[1] > low[2] and high[1] > high[2] and
                   open[1] ~= close[1] and abs(open[1] - close[2]) >
                   abs(open[2] - close[2])

marubozu_call = ((open[1] > close[1]) and
                    (close[1] < high[1] - ((high[1] - low[1]) * 0.02)) and
                    (open[1] < high[1] + ((high[1] - low[1]) * 0.02)) and
                    (abs(close[1] - open[1])) < ((high[1] - low[1]) * 0.95)) and
                    open[1] > sma(close[1], 20) and close[1] < sma(close[1], 20) and
                    doji == false and real_ > 20 and ema_call


shootingstar3_put = ((open[1] < close[1]) or (open[1] > close[1])) and open[1] <
                        low[1] + ((high[1] - low[1]) * 0.05) and
                        (abs(close[1] - open[1])) <= ((high[1] - low[1]) * 0.6) and
                        doji == false and open[2] <= close[1] and upper_ > 0 and
                        ema_put and open[2] < close[2] and
                        (high[1] > ema100 or high[1] > ema200)

shootingstar2_put = ((open[1] < close[1]) or (open[1] > close[1])) and open[1] <
                        low[1] + ((high[1] - low[1]) * 0.05) and
                        (abs(close[1] - open[1])) <= ((high[1] - low[1]) * 0.6) and
                        doji == false and open[2] <= close[1] and upper_ > 0 and
                        ema_put and open[2] < close[2] and
                        (high[1] > ema50 or high[1] > ema100)

shootingstar1_put = ((open[1] < close[1]) or (open[1] > close[1])) and open[1] <
                        low[1] + ((high[1] - low[1]) * 0.05) and
                        (abs(close[1] - open[1])) <= ((high[1] - low[1]) * 0.6) and
                        doji == false and open[2] <= close[1] and upper_ > 0 and
                        ema_put and open[2] < close[2] and
                        (high[1] > ema20 or high[1] > ema50)

 hhhl1_buy = high[1] < BBUpper18 and close[1] > close[2] and open[1] > open[2] and
        open[2] < close[2] and open[1] < close[1] and close[2] < open[3] and
        close[1] > high[2] and close[1] ~= high[1] and close[1] ~= high[2] and
        close[1] ~= high[3] and close[1] ~= high[4] and real_ > 5 and ema_call and
        ema_call and doji == false

minor_down = (open[4] <= close[4] and open[3] <= close[3] and open[2] >=
        close[2] and open[1] >= close[1]) and
        ((close[3] > BBUpper18) or (close[2] > BBUpper18) or
            (high[2] > BBUpper18) or (high[3] > BBUpper18)) and ema_put

plot_shape(minor_down, 'minorDown_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "MD",
           put_color)
plot_shape(hhhl1_buy, 'hhhl_1_BUY', shape_style.arrowup, shape_size.large,
        'transparent', shape_location.belowbar, 0, "HH", call_color)plot_shape(hhhl1_buy, 'hhhl_1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "HH", call_color)

plot_shape(gapDown_call, 'gapDown_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "GD", call_color)
plot_shape(gapUp_put, 'gapUp_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "GU", put_color)

plot_shape(shootingstar3_put, 'shootingstar3_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "SST3",
           put_color)
plot_shape(shootingstar2_put, 'shootingstar2_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "SST2",
           put_color)
plot_shape(shootingstar1_put, 'shootingstar1_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "SST1",
           put_color)
plot_shape(marubozu_call, 'marubozu_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "MA", call_color)
