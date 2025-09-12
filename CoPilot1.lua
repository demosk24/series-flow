instrument {overlay = true, name = 'CoPilot1', short_name = 'BOTTPA'}

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

gravestone_call = abs(close[1] - open[1]) / (high[1] - low[1]) < 0.1 and
                      (min(close[1], open[1]) - low[1]) >
                      (3 * abs(close[1] - open[1])) and
                      (high[1] - max(close[1], open[1])) <
                      abs(close[1] - open[1]) and close[1] == low[1] and
                      ema_call

dragonfly_put = abs(close[1] - open[1]) / (high[1] - low[1]) < 0.1 and
                    (min(close[1], open[1]) - low[1]) >
                    (3 * abs(close[1] - open[1])) and
                    (high[1] - max(close[1], open[1])) < abs(close[1] - open[1]) and
                    close[1] == high[1] and ema_put and high[1] > ema20

marubozu_call = ((open[1] > close[1]) and
                    (close[1] < high[1] - ((high[1] - low[1]) * 0.02)) and
                    (open[1] < high[1] + ((high[1] - low[1]) * 0.02)) and
                    (abs(close[1] - open[1])) < ((high[1] - low[1]) * 0.95)) and
                    open[1] > sma(close[1], 20) and close[1] < sma(close[1], 20) and
                    doji == false and real_ > 20 and ema_call

marubozu_put = ((open[1] < close[1]) and
                   (close[1] > high[1] - ((high[1] - low[1]) * 0.02)) and
                   (open[1] < low[1] + ((high[1] - low[1]) * 0.02)) and
                   (abs(close[1] - open[1])) > ((high[1] - low[1]) * 0.95)) and
                   open[1] < sma(close[1], 20) and close[1] > sma(close[1], 20) and
                   doji == false and real_ > 20 and ema_put

invertedhammer_put = (open[1] < close[1]) and open[1] < low[1] +
                         ((high[1] - low[1]) * 0.05) and
                         (abs(close[1] - open[1])) <= ((high[1] - low[1]) * 0.6) and
                         open[2] <= close[1] and ema_put and low[1] < BBLower2 and
                         open[2] > close[2] and open[3] > close[3]

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

exc_1_sell =
    close[1] < open[1] and close[2] < open[2] and close[3] < open[3] and open[2] -
        close[2] > open[1] - close[1] and open[2] - close[2] < open[3] -
        close[3] and open[3] - close[3] < open[4] - close[4] and low[2] <
        BBLower2 and ema_put and close[1] < BBLower2

exc_1_buy = close[1] > open[1] and close[2] > open[2] and close[3] > open[3] and
                open[2] - close[2] > open[1] - close[1] and open[2] - close[2] <
                open[3] - close[3] and open[3] - close[3] < open[4] - close[4] and
                high[2] > BBUpper2 and ema_call and close[1] > BBUpper2

exr_1_buy = close[1] < open[1] and close[2] < open[2] and close[3] < open[3] and
                open[2] - close[2] < open[1] - close[1] and open[2] - close[2] <
                open[3] - close[3] and open[1] - close[1] > open[3] - close[3] and
                open[3] - close[3] < open[4] - close[4] and
                abs(close[3] - open[3]) > abs(close[2] - open[2]) and
                abs(close[2] - close[2]) < abs(close[1] - open[1]) and real_ > 8 and
                ema_call and doji == false

exr_1_buy_ME =
    close[1] < open[1] and close[2] < open[2] and close[3] < open[3] and open[2] -
        close[2] < open[1] - close[1] and open[2] - close[2] < open[3] -
        close[3] and open[1] - close[1] > open[3] - close[3] and open[3] -
        close[3] < open[4] - close[4] and abs(close[3] - open[3]) >
        abs(close[2] - open[2]) and abs(close[2] - close[2]) <
        abs(close[1] - open[1]) and real_ > 8 and doji == false

exr_1_sell =
    close[1] > open[1] and close[2] > open[2] and close[3] > open[3] and open[2] -
        close[2] > open[1] - close[1] and open[2] - close[2] > open[3] -
        close[3] and open[1] - close[1] < open[3] - close[3] and open[3] -
        close[3] > open[4] - close[4] and abs(close[3] - open[3]) >
        abs(close[2] - open[2]) and abs(close[2] - close[2]) <
        abs(close[1] - open[1]) and real_ > 8 and ema_put and doji == false

plot_shape(gapDown_call, 'gapDown_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "GD", call_color)
plot_shape(gapUp_put, 'gapUp_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "GU", put_color)

plot_shape(marubozu_call, 'marubozu_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "MA", call_color)
plot_shape(marubozu_put, 'marubozu_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "MA",
           put_color)

plot_shape(invertedhammer_put, 'invertedhammer_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "IHA1",
           call_color)
plot_shape(shootingstar3_put, 'shootingstar3_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "SST3",
           put_color)
plot_shape(shootingstar2_put, 'shootingstar2_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "SST2",
           put_color)
plot_shape(shootingstar1_put, 'shootingstar1_SELL', shape_style.arrowdown,
           shape_size.large, 'transparent', shape_location.abovebar, 0, "SST1",
           put_color)
plot_shape(exc_1_buy, 'EXC_1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "EXC1", call_color)
plot_shape(exc_1_sell, 'EXC_1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "EXC1", put_color)

plot_shape(exr_1_buy, 'EXR_1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "EXR1", call_color)

plot_shape(exr_1_sell, 'EXR_1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "EXR1", put_color)
