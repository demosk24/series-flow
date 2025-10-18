instrument {overlay = true, name = '3WS/BC Eng', short_name = 'BOTTPA'}

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


BBUpper2 = sma(close[1], BBperiod) + stdev(close[1], BBperiod) * 2
BBLower2 = sma(close[1], BBperiod) - stdev(close[1], BBperiod) * 2


ema_put = close[1] < ema20 and ema20 < ema50 and ema50 < ema100 and ema100 <
              ema200
ema_call = close[1] > ema20 and ema20 > ema50 and ema50 > ema100 and ema100 >
               ema200

doji = (abs(open[1] - close[1]) <= (high[1] - low[1]) * 0.2)


                                            
           
                                               


bull = open[6] > close[6] and open[5] < close[5] and open[4] < close[4] and open[3] < close[3] and open[2] > close[2] and open[1] < close[1] and open[2] < close[1]
ber = open[6] < close[6] and open[5] > close[5] and open[4] > close[4] and open[3] > close[3] and open[2] < close[2] and open[1] > close[1] and open[2] > close[1]

 plot_shape(bull, 'huge_candle1_BUY', shape_style.arrowup,
                                 shape_size.large, 'transparent', shape_location.belowbar, 0, "HC1",
                                 call_color)
plot_shape(ber, 'huge_candle1_SELL', shape_style.arrowdown,
                                 shape_size.large, 'transparent', shape_location.abovebar, 0, "HC1",
                                 put_color)
