instrument {overlay = true, name = 'CoPilot5', short_name = 'BOTTPA'}

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

nrs_1_buy = close[1] > open[1] and close[2] < open[2] and close[3] > open[3] and
                close[2] == open[3] and close[1] > close[2] and
                (open[1] < ((((open[2] - close[2]) * 50) / 100) + close[2])) and
                doji == false and ema_call and close[1] < BBUpper18 and real_ >
                5 and close[1] > BBUpper1 and high[2] * 20 / 100 - high[2] <
                open[1] and (close[1] - open[1]) > (close[2] - open[2]) * 5

nrs_1_sell =
    close[1] < open[1] and close[2] > open[2] and close[3] < open[3] and
        close[3] == open[2] and open[1] < close[2] and
        (open[1] > ((((open[2] - close[2]) * 50) / 100) + close[2])) and doji ==
        false and ema_put and close[1] > BBLower18 and real_ > 5 and close[1] <
        BBLower1 and low[2] * 20 / 100 - low[2] < close[1] and
        (close[1] - open[1]) < (close[2] - open[2]) * 5

ems_1_sell = close[1] == ((((close[3] - open[3]) * 100) / 100) + open[3]) and
                 open[3] > close[3] and
                 (open[2] <= close[2] or open[2] >= close[2]) and open[1] <
                 close[1] and close[1] < BBLower1 and close[1] > BBLower2 and
                 ema_put and (close[3] > BBLower2_3) and close[4] < open[4] and
                 close[3] < open[3] and close[2] < open[3] and close[1] >
                 close[2] and real_ > 4

ees_1_buy = close[1] == ((((close[3] - open[3]) * 100) / 100) + open[3]) and
                open[3] < close[3] and
                (open[2] <= close[2] or open[2] >= close[2]) and open[1] >
                close[1] and (close[1] > BBUpper1 or close[1] < BBLower1) and
                ema_call and (close[3] < BBUpper2_3) and close[4] > open[4] and
                close[3] > open[3] and close[2] > open[3] and close[1] <
                close[2] and real_ > 4

ms50_1_sell = close[1] == ((((close[3] - open[3]) * 50) / 100) + open[3]) and
                  open[3] > close[3] and
                  (open[2] <= close[2] or open[2] >= close[2]) and open[1] <
                  close[1] and close[1] < BBLower1 and close[1] > BBLower2 and
                  ema_put and (close[3] > BBLower2_3) and close[4] < open[4] and
                  close[3] < open[3] and close[2] < open[3] and close[1] >
                  close[2] and real_ > 4

es50_1_buy = close[1] == ((((close[3] - open[3]) * 50) / 100) + open[3]) and
                 open[3] < close[3] and
                 (open[2] <= close[2] or open[2] >= close[2]) and open[1] >
                 close[1] and (close[1] > BBUpper1 or close[1] < BBLower1) and
                 ema_call and (close[3] < BBUpper2_3) and close[4] > open[4] and
                 close[3] > open[3] and close[2] > open[3] and close[1] <
                 close[2] and real_ > 4

eng7_buy =
    close[1] > BBUpper1 and high[1] < BBUpper18 and close[2] < open[2] and
        open[2] < close[1] and close[1] > open[2] and doji == false and close[1] >
        high[3] and close[1] > high[2] and close[1] > ema200 and close[2] <
        ema200 and open[1] < ema200 and ema200 < ema100 and close[3] < open[3] and
        close[4] < open[4] and real_ < 30 and close[1] > high[2] and close[1] >
        high[3] and close[3] < open[3] and close[4] < open[4] and close[5] >
        open[5]

eng7_sell =
    close[1] < BBLower1 and low[1] > BBLower18 and close[2] > open[2] and
        open[2] > close[1] and close[1] < open[2] and close[1] < ema200 and
        close[2] < ema200 and open[1] < ema200 and ema200 > ema100 and close[3] >
        open[3] and close[4] > open[4] and real_ < 30 and close[1] < low[2] and
        close[1] < low[3] and close[3] > open[3] and close[4] > open[4] and
        close[5] < open[5]

eng6_buy = close[1] > BBUpper1 and close[2] < open[2] and open[1] < close[1] and
               close[1] > open[2] and doji == false and close[1] > high[3] and
               close[1] > high[2] and close[1] > ema100 and close[2] < ema100 and
               open[1] < ema100 and ema200 < ema100 and close[3] < open[3] and
               close[4] < open[4] and real_ < 30 and close[1] > high[2] and
               close[1] > high[3] and close[3] < open[3] and close[4] < open[4] and
               close[5] > open[5]

eng6_sell =
    close[1] < BBLower1 and close[2] > open[2] and open[2] > close[1] and
        close[1] < open[2] and close[1] < ema100 and close[2] < ema100 and
        open[1] < ema100 and ema200 > ema100 and close[3] > open[3] and close[4] >
        open[4] and real_ < 30 and close[1] < low[2] and close[1] < low[3] and
        close[3] > open[3] and close[4] > open[4] and close[5] < open[5]

eng5_buy = close[1] < BBUpper2 and close[2] < open[2] and open[1] < close[1] and
               close[1] > open[2] and doji == false and close[1] > high[3] and
               close[1] > high[2] and close[1] > ema50 and close[2] < ema50 and
               open[1] < ema50 and ema200 < ema100 and ema100 < ema50 and
               close[3] < open[3] and close[4] < open[4] and real_ < 30 and
               close[1] > high[2] and close[1] > high[3] and close[3] < open[3] and
               close[4] < open[4] and close[5] > open[5]

eng5_sell =
    close[1] > BBLower2 and close[2] > open[2] and open[2] > close[1] and
        close[1] < open[2] and doji == false and close[1] < low[3] and close[1] <
        low[2] and close[1] < ema50 and close[2] < ema50 and open[1] < ema50 and
        ema200 > ema100 and ema100 > ema50 and close[3] > open[3] and close[4] >
        open[4] and real_ < 30 and close[1] < low[2] and close[1] < low[3] and
        close[3] > open[3] and close[4] > open[4] and close[5] < open[5]

plot_shape(eng7_buy, 'eng7_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "Eng7", call_color)
plot_shape(eng7_sell, 'eng7_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "Eng7", put_color)

plot_shape(eng6_buy, 'eng6_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "Eng6", call_color)
plot_shape(eng6_sell, 'eng6_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "Eng6", put_color)

plot_shape(eng5_buy, 'eng5_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "Eng5", call_color)
plot_shape(eng5_sell, 'eng5_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "Eng5", put_color)

plot_shape(nrs_1_buy, 'NRS_1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "NRS1", call_color)
plot_shape(nrs_1_sell, 'NRS_1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "NRS1", put_color)

plot_shape(ems_1_sell, 'EMS_1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "EMS1", put_color)
plot_shape(ees_1_buy, 'EES_1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "EES1", call_color)

plot_shape(ms50_1_sell, 'MS50_1_SELL', shape_style.arrowdown, shape_size.large,
           'transparent', shape_location.abovebar, 0, "MS501", put_color)
plot_shape(es50_1_buy, 'ES50_1_BUY', shape_style.arrowup, shape_size.large,
           'transparent', shape_location.belowbar, 0, "ES501", call_color)
