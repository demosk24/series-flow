instrument {
    name = "CPD",
    short_name = "yCPD",
    overlay = true 
}

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

BBperiod = 20

BBUpper2 = sma(close[1], BBperiod) + stdev(close[1], BBperiod) * 2
BBLower2 = sma(close[1], BBperiod) - stdev(close[1], BBperiod) * 2

dojiDD = (abs(open[1] - close[1]) <= (high[1] - low[1]) * 0.2)

bull_seris= close[2] > open[2] or close[3] > open[3] or close[4] > open[4] or close[5] > open[5]
ber_seris= close[2] < open[2] or close[3] < open[3] or close[4] < open[4] or close[5] > open[5]

local hammerC2 = close[2] > open[2] and ((min(open[2], close[2]) - low[2]) >= 2 * abs(open[2] - close[2])) and ((high[2] - max(open[2], close[2])) <= 0.5 * abs(open[2] - close[2])) and not (abs(open[2] - close[2]) <= (high[2] - low[2]) * 0.2)

local hammerC3 = close[3] > open[3] and ((min(open[3], close[3]) - low[3]) >= 2 * abs(open[3] - close[3])) and ((high[3] - max(open[3], close[3])) <= 0.5 * abs(open[3] - close[3])) and not (abs(open[3] - close[3]) <= (high[3] - low[3]) * 0.2)

local hammerC4 = close[4] > open[4] and ((min(open[4], close[4]) - low[4]) >= 2 * abs(open[4] - close[4])) and ((high[4] - max(open[4], close[4])) <= 0.5 * abs(open[4] - close[4])) and not (abs(open[4] - close[4]) <= (high[4] - low[4]) * 0.2)

local hammerC5 = close[5] > open[5] and ((min(open[5], close[5]) - low[5]) >= 2 * abs(open[5] - close[5])) and ((high[5] - max(open[5], close[5])) <= 0.5 * abs(open[5] - close[5])) and not (abs(open[5] - close[5]) <= (high[5] - low[5]) * 0.2)

local hammer2C2 = close[2] > open[2] and ((min(open[2], close[2]) - low[2]) > abs(open[2] - close[2])) and ((min(open[2], close[2]) - low[2]) > (high[2] - max(open[2], close[2]))) and ((high[2] - max(open[2], close[2])) < abs(open[2] - close[2])) and not hammerC2 and not (abs(open[2] - close[2]) <= (high[2] - low[2]) * 0.2)

local hammer2C3 = close[3] > open[3] and ((min(open[3], close[3]) - low[3]) > abs(open[3] - close[3])) and ((min(open[3], close[3]) - low[3]) > (high[3] - max(open[3], close[3]))) and ((high[3] - max(open[3], close[3])) < abs(open[3] - close[3])) and not hammerC3 and not (abs(open[3] - close[3]) <= (high[3] - low[3]) * 0.2)

local hammer2C4 = close[4] > open[4] and ((min(open[4], close[4]) - low[4]) > abs(open[4] - close[4])) and ((min(open[4], close[4]) - low[4]) > (high[4] - max(open[4], close[4]))) and ((high[4] - max(open[4], close[4])) < abs(open[4] - close[4])) and not hammerC4 and not (abs(open[4] - close[4]) <= (high[4] - low[4]) * 0.2)

local hammer2C5 = close[5] > open[5] and ((min(open[5], close[5]) - low[5]) > abs(open[5] - close[5])) and ((min(open[5], close[5]) - low[5]) > (high[5] - max(open[5], close[5]))) and ((high[5] - max(open[5], close[5])) < abs(open[5] - close[5])) and not hammerC5 and not (abs(open[5] - close[5]) <= (high[5] - low[5]) * 0.2)


local inverted_hammerC2 = close[2] > open[2] and ((high[2] - max(open[2], close[2])) >= 2 * abs(open[2] - close[2])) and ((min(open[2], close[2]) - low[2]) <= 0.5 * abs(open[2] - close[2])) and not (abs(open[2] - close[2]) <= (high[2] - low[2]) * 0.2)

local inverted_hammer2C2 = close[2] > open[2] and ((min(open[2], close[2]) - low[2]) < abs(open[2] - close[2])) and ((min(open[2], close[2]) - low[2]) < (high[2] - max(open[2], close[2]))) and ((high[2] - max(open[2], close[2])) > abs(open[2] - close[2])) and not inverted_hammerC2 and not (abs(open[2] - close[2]) <= (high[2] - low[2]) * 0.2)

local hanging_manC2 = close[2] < open[2] and ((min(open[2], close[2]) - low[2]) >= 2 * abs(open[2] - close[2])) and ((high[2] - max(open[2], close[2])) <= 0.5 * abs(open[2] - close[2])) and not (abs(open[2] - close[2]) <= (high[2] - low[2]) * 0.2)

local hanging_man2C2 = close[2] < open[2] and ((min(open[2], close[2]) - low[2]) > abs(open[2] - close[2])) and ((min(open[2], close[2]) - low[2]) > (high[2] - max(open[2], close[2]))) and ((high[2] - max(open[2], close[2])) < abs(open[2] - close[2])) and not hanging_manC2 and not (abs(open[2] - close[2]) <= (high[2] - low[2]) * 0.2)

local shooting_starC2 = close[2] < open[2] and ((high[2] - max(open[2], close[2])) >= 2 * abs(open[2] - close[2])) and ((min(open[2], close[2]) - low[2]) <= 0.5 * abs(open[2] - close[2])) and not (abs(open[2] - close[2]) <= (high[2] - low[2]) * 0.2)

local shooting_star2C2 = close[2] < open[2] and ((min(open[2], close[2]) - low[2]) < abs(open[2] - close[2])) and ((min(open[2], close[2]) - low[2]) < (high[2] - max(open[2], close[2]))) and ((high[2] - max(open[2], close[2])) > abs(open[2] - close[2])) and not shooting_starC2 and not (abs(open[2] - close[2]) <= (high[2] - low[2]) * 0.2)

local inverted_hammerC3 = close[3] > open[3] and ((high[3] - max(open[3], close[3])) >= 2 * abs(open[3] - close[3])) and ((min(open[3], close[3]) - low[3]) <= 0.5 * abs(open[3] - close[3])) and not (abs(open[3] - close[3]) <= (high[3] - low[3]) * 0.2)

local inverted_hammer2C3 = close[3] > open[3] and ((min(open[3], close[3]) - low[3]) < abs(open[3] - close[3])) and ((min(open[3], close[3]) - low[3]) < (high[3] - max(open[3], close[3]))) and ((high[3] - max(open[3], close[3])) > abs(open[3] - close[3])) and not inverted_hammerC3 and not (abs(open[3] - close[3]) <= (high[3] - low[3]) * 0.2)

local hanging_manC3 = close[3] < open[3] and ((min(open[3], close[3]) - low[3]) >= 2 * abs(open[3] - close[3])) and ((high[3] - max(open[3], close[3])) <= 0.5 * abs(open[3] - close[3])) and not (abs(open[3] - close[3]) <= (high[3] - low[3]) * 0.2)

local hanging_man2C3 = close[3] < open[3] and ((min(open[3], close[3]) - low[3]) > abs(open[3] - close[3])) and ((min(open[3], close[3]) - low[3]) > (high[3] - max(open[3], close[3]))) and ((high[3] - max(open[3], close[3])) < abs(open[3] - close[3])) and not hanging_manC3 and not (abs(open[3] - close[3]) <= (high[3] - low[3]) * 0.2)

local shooting_starC3 = close[3] < open[3] and ((high[3] - max(open[3], close[3])) >= 2 * abs(open[3] - close[3])) and ((min(open[3], close[3]) - low[3]) <= 0.5 * abs(open[3] - close[3])) and not (abs(open[3] - close[3]) <= (high[3] - low[3]) * 0.2)

local shooting_star2C3 = close[3] < open[3] and ((min(open[3], close[3]) - low[3]) < abs(open[3] - close[3])) and ((min(open[3], close[3]) - low[3]) < (high[3] - max(open[3], close[3]))) and ((high[3] - max(open[3], close[3])) > abs(open[3] - close[3])) and not shooting_starC3 and not (abs(open[3] - close[3]) <= (high[3] - low[3]) * 0.2)

local inverted_hammerC4 = close[4] > open[4] and ((high[4] - max(open[4], close[4])) >= 2 * abs(open[4] - close[4])) and ((min(open[4], close[4]) - low[4]) <= 0.5 * abs(open[4] - close[4])) and not (abs(open[4] - close[4]) <= (high[4] - low[4]) * 0.2)

local inverted_hammer2C4 = close[4] > open[4] and ((min(open[4], close[4]) - low[4]) < abs(open[4] - close[4])) and ((min(open[4], close[4]) - low[4]) < (high[4] - max(open[4], close[4]))) and ((high[4] - max(open[4], close[4])) > abs(open[4] - close[4])) and not inverted_hammerC4 and not (abs(open[4] - close[4]) <= (high[4] - low[4]) * 0.2)

local hanging_manC4 = close[4] < open[4] and ((min(open[4], close[4]) - low[4]) >= 2 * abs(open[4] - close[4])) and ((high[4] - max(open[4], close[4])) <= 0.5 * abs(open[4] - close[4])) and not (abs(open[4] - close[4]) <= (high[4] - low[4]) * 0.2)

local hanging_man2C4 = close[4] < open[4] and ((min(open[4], close[4]) - low[4]) > abs(open[4] - close[4])) and ((min(open[4], close[4]) - low[4]) > (high[4] - max(open[4], close[4]))) and ((high[4] - max(open[4], close[4])) < abs(open[4] - close[4])) and not hanging_manC4 and not (abs(open[4] - close[4]) <= (high[4] - low[4]) * 0.2)

local shooting_starC4 = close[4] < open[4] and ((high[4] - max(open[4], close[4])) >= 2 * abs(open[4] - close[4])) and ((min(open[4], close[4]) - low[4]) <= 0.5 * abs(open[4] - close[4])) and not (abs(open[4] - close[4]) <= (high[4] - low[4]) * 0.2)

local shooting_star2C4 = close[4] < open[4] and ((min(open[4], close[4]) - low[4]) < abs(open[4] - close[4])) and ((min(open[4], close[4]) - low[4]) < (high[4] - max(open[4], close[4]))) and ((high[4] - max(open[4], close[4])) > abs(open[4] - close[4])) and not shooting_starC4 and not (abs(open[4] - close[4]) <= (high[4] - low[4]) * 0.2)

local inverted_hammerC5 = close[5] > open[5] and ((high[5] - max(open[5], close[5])) >= 2 * abs(open[5] - close[5])) and ((min(open[5], close[5]) - low[5]) <= 0.5 * abs(open[5] - close[5])) and not (abs(open[5] - close[5]) <= (high[5] - low[5]) * 0.2)

local inverted_hammer2C5 = close[5] > open[5] and ((min(open[5], close[5]) - low[5]) < abs(open[5] - close[5])) and ((min(open[5], close[5]) - low[5]) < (high[5] - max(open[5], close[5]))) and ((high[5] - max(open[5], close[5])) > abs(open[5] - close[5])) and not inverted_hammerC5 and not (abs(open[5] - close[5]) <= (high[5] - low[5]) * 0.2)

local hanging_manC5 = close[5] < open[5] and ((min(open[5], close[5]) - low[5]) >= 2 * abs(open[5] - close[5])) and ((high[5] - max(open[5], close[5])) <= 0.5 * abs(open[5] - close[5])) and not (abs(open[5] - close[5]) <= (high[5] - low[5]) * 0.2)

local hanging_man2C5 = close[5] < open[5] and ((min(open[5], close[5]) - low[5]) > abs(open[5] - close[5])) and ((min(open[5], close[5]) - low[5]) > (high[5] - max(open[5], close[5]))) and ((high[5] - max(open[5], close[5])) < abs(open[5] - close[5])) and not hanging_manC5 and not (abs(open[5] - close[5]) <= (high[5] - low[5]) * 0.2)

local shooting_starC5 = close[5] < open[5] and ((high[5] - max(open[5], close[5])) >= 2 * abs(open[5] - close[5])) and ((min(open[5], close[5]) - low[5]) <= 0.5 * abs(open[5] - close[5])) and not (abs(open[5] - close[5]) <= (high[5] - low[5]) * 0.2)

local shooting_star2C5 = close[5] < open[5] and ((min(open[5], close[5]) - low[5]) < abs(open[5] - close[5])) and ((min(open[5], close[5]) - low[5]) < (high[5] - max(open[5], close[5]))) and ((high[5] - max(open[5], close[5])) > abs(open[5] - close[5])) and not shooting_starC5 and not (abs(open[5] - close[5]) <= (high[5] - low[5]) * 0.2)


local doji = (abs(open - close) <= (high - low) * 0.2)
local dragonfly_doji = (bull_seris or ber_seris) and (abs(open - close) <= (high - low) * 0.2) and ((min(open, close) - low) > (high - max(open, close))) and ((high - max(open, close)) < abs(open - close))
local gravestone_doji = (bull_seris or ber_seris) and (abs(open - close) <= (high - low) * 0.2) and ((high - max(open, close)) > (min(open, close) - low)) and ((min(open, close) - low) < abs(open - close))


bASED = hammerC2 or hammerC3 or hammerC4 or hammerC5 or hammer2C2 or hammer2C3 or hammer2C4 or hammer2C5 or inverted_hammerC2 or inverted_hammer2C2 or hanging_manC2 or hanging_man2C2 or shooting_starC2 or shooting_star2C2 or inverted_hammerC3 or inverted_hammer2C3 or hanging_manC3 or hanging_man2C3 or shooting_starC3 or shooting_star2C3 or inverted_hammerC4 or inverted_hammer2C4 or hanging_manC4 or hanging_man2C4 or shooting_starC4 or shooting_star2C4 or inverted_hammerC5 or inverted_hammer2C5 or hanging_manC5 or hanging_man2C5 or shooting_starC5 or shooting_star2C5 or doji or dragonfly_doji or gravestone_doji


huge_candle1_sell = close[1] > BBUpper2 and close[1] > open[1] and close[2] > open[2] and real_ > 50 and abs(open[1] - close[1]) > abs(open[2] - close[2]) and bASED
                        
huge_candle1_buy = close[1] < BBLower2 and close[1] < open[1] and close[2] < open[2] and real_ > 50 and abs(open[1] - close[1]) > abs(open[2] - close[2]) and bASED

plot_shape(huge_candle1_buy, 'huge_candle1_BUY', shape_style.arrowup,
                                 shape_size.large, 'transparent', shape_location.belowbar, 0, "HC1",
                                 call_color)
plot_shape(huge_candle1_sell, 'huge_candle1_SELL', shape_style.arrowdown,
                                 shape_size.large, 'transparent', shape_location.abovebar, 0, "HC1",
                                 put_color)
