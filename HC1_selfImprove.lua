instrument {overlay = true, name = 'HC1_selfImprove', short_name = 'BOTTPA'}

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

upperX = abs(high - max(open, close))
lowerX = abs(min(open, close) - low)
realX = abs(close - open) * 1.75                                         
                                        
weakbar= realX < upperX or realX < lowerX

huge_candle1_sell = close[1] > BBUpper2 and close[1] > open[1] and close[2] >
                                                open[2] and real_ > 50 and abs(open[1] - close[1]) >
                                                abs(open[2] - close[2])
                        
huge_candle1_buy = close[1] < BBLower2 and close[1] < open[1] and close[2] <
                                               open[2] and real_ > 50 and abs(open[1] - close[1]) >
                                               abs(open[2] - close[2]) and current_bar_id ~= 212
                                            
                                        

 plot_shape(huge_candle1_buy and weakbar, 'huge_candle1_BUY', shape_style.arrowup,
                                 shape_size.large, 'transparent', shape_location.belowbar, 0, "HC1",
                                 call_color)
plot_shape(huge_candle1_sell and weakbar, 'huge_candle1_SELL', shape_style.arrowdown,
                                 shape_size.large, 'transparent', shape_location.abovebar, 0, "HC1",
                                 put_color)
