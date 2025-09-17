instrument {
    name = "Candlestick Patterns Detector",
    short_name = "CPD",
    overlay = true  -- Overlay on the main chart
}

-- Input groups for customizable colors and visibility
input_group {
    "Bullish Signals",
    bullish_color = input { default = "#00FF00", type = input.color },  -- Green for bullish
    bullish_visible = input { default = true, type = input.plot_visibility }
}

input_group {
    "Bearish Signals",
    bearish_color = input { default = "#FF0000", type = input.color },  -- Red for bearish
    bearish_visible = input { default = true, type = input.plot_visibility }
}

input_group {
    "Neutral Signals",
    neutral_color = input { default = "#FFFF00", type = input.color },  -- Yellow for neutral
    neutral_visible = input { default = true, type = input.plot_visibility }
}

-- Helper variables for current candle
local body = abs(open - close)
local upper_shadow = high - max(open, close)
local lower_shadow = min(open, close) - low
local range = high - low
local is_bullish = close > open
local is_bearish = close < open
local is_doji = body <= (range * 0.05)  -- Small body for Doji (adjust threshold as needed)

-- Helper variables for previous candle
local prev_body = abs(open[1] - close[1])
local prev_upper_shadow = high[1] - max(open[1], close[1])
local prev_lower_shadow = min(open[1], close[1]) - low[1]
local prev_range = high[1] - low[1]
local prev_is_bullish = close[1] > open[1]
local prev_is_bearish = close[1] < open[1]
local prev_is_doji = prev_body <= (prev_range * 0.05)

-- Single Candlestick Patterns

-- Hammer (Bullish Reversal)
local hammer = is_bullish and (lower_shadow >= 2 * body) and (upper_shadow <= 0.5 * body)

-- Inverted Hammer (Bullish Reversal)
local inverted_hammer = is_bullish and (upper_shadow >= 2 * body) and (lower_shadow <= 0.5 * body)

-- Hanging Man (Bearish Reversal)
local hanging_man = is_bearish and (lower_shadow >= 2 * body) and (upper_shadow <= 0.5 * body)

-- Shooting Star (Bearish Reversal)
local shooting_star = is_bearish and (upper_shadow >= 2 * body) and (lower_shadow <= 0.5 * body)

-- Doji (Neutral Indecision)
local doji = is_doji

-- Dragonfly Doji (Bullish Reversal)
local dragonfly_doji = is_doji and (lower_shadow > upper_shadow) and (upper_shadow < body)

-- Gravestone Doji (Bearish Reversal)
local gravestone_doji = is_doji and (upper_shadow > lower_shadow) and (lower_shadow < body)

-- Long Legged Doji (Neutral Indecision)
local long_legged_doji = is_doji and (upper_shadow > 0.4 * range) and (lower_shadow > 0.4 * range)

-- Spinning Top (Neutral Indecision)
local spinning_top = (body <= 0.3 * range) and (upper_shadow > body) and (lower_shadow > body)

-- Bullish Marubozu (Bullish Continuation)
local bullish_marubozu = is_bullish and (upper_shadow < 0.1 * body) and (lower_shadow < 0.1 * body)

-- Bearish Marubozu (Bearish Continuation)
local bearish_marubozu = is_bearish and (upper_shadow < 0.1 * body) and (lower_shadow < 0.1 * body)

-- Double Candlestick Patterns

-- Bullish Engulfing (Bullish Reversal)
local bullish_engulfing = prev_is_bearish and is_bullish and (open < close[1]) and (close > open[1])

-- Bearish Engulfing (Bearish Reversal)
local bearish_engulfing = prev_is_bullish and is_bearish and (open > close[1]) and (close < open[1])

-- Piercing Line (Bullish Reversal)
local piercing_line = prev_is_bearish and is_bullish and (open < close[1]) and (close > (open[1] + close[1]) / 2)

-- Dark Cloud Cover (Bearish Reversal)
local dark_cloud_cover = prev_is_bullish and is_bearish and (open > close[1]) and (close < (open[1] + close[1]) / 2)

-- Bullish Harami (Bullish Reversal)
local bullish_harami = prev_is_bearish and is_bullish and (open > close[1]) and (close < open[1])

-- Bearish Harami (Bearish Reversal)
local bearish_harami = prev_is_bullish and is_bearish and (open < close[1]) and (close > open[1])

-- Bullish Harami Cross (Bullish Reversal)
local bullish_harami_cross = prev_is_bearish and is_doji and (open > close[1]) and (close < open[1])

-- Bearish Harami Cross (Bearish Reversal)
local bearish_harami_cross = prev_is_bullish and is_doji and (open < close[1]) and (close > open[1])

-- Tweezer Bottom (Bullish Reversal)
local tweezer_bottom = prev_is_bearish and is_bullish and (abs(low - low[1]) < 0.1 * range)

-- Tweezer Top (Bearish Reversal)
local tweezer_top = prev_is_bullish and is_bearish and (abs(high - high[1]) < 0.1 * range)

-- Bullish Kicker (Bullish Reversal)
local bullish_kicker = prev_is_bearish and is_bullish and (open > close[1])

-- Bearish Kicker (Bearish Reversal)
local bearish_kicker = prev_is_bullish and is_bearish and (open < close[1])

-- Plotting Signals for Single and Double Patterns

-- Bullish Patterns
if bullish_visible then
    if hammer then
        plot_shape(true, "Hammer", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Hammer", bullish_color)
    end
    if inverted_hammer then
        plot_shape(true, "Inverted Hammer", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Inv Hammer", bullish_color)
    end
    if dragonfly_doji then
        plot_shape(true, "Dragonfly Doji", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Dragon Doji", bullish_color)
    end
    if bullish_marubozu then
        plot_shape(true, "Bullish Marubozu", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Bull Maru", bullish_color)
    end
    if bullish_engulfing then
        plot_shape(true, "Bullish Engulfing", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Bull Engulf", bullish_color)
    end
    if piercing_line then
        plot_shape(true, "Piercing Line", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Piercing", bullish_color)
    end
    if bullish_harami then
        plot_shape(true, "Bullish Harami", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Bull Harami", bullish_color)
    end
    if bullish_harami_cross then
        plot_shape(true, "Bullish Harami Cross", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Bull H Cross", bullish_color)
    end
    if tweezer_bottom then
        plot_shape(true, "Tweezer Bottom", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Tweezer Bot", bullish_color)
    end
    if bullish_kicker then
        plot_shape(true, "Bullish Kicker", shape_style.triangleup, shape_size.large, bullish_color, shape_location.belowbar, 0, "Bull Kicker", bullish_color)
    end
end

-- Bearish Patterns
if bearish_visible then
    if hanging_man then
        plot_shape(true, "Hanging Man", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Hang Man", bearish_color)
    end
    if shooting_star then
        plot_shape(true, "Shooting Star", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Shoot Star", bearish_color)
    end
    if gravestone_doji then
        plot_shape(true, "Gravestone Doji", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Grave Doji", bearish_color)
    end
    if bearish_marubozu then
        plot_shape(true, "Bearish Marubozu", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Bear Maru", bearish_color)
    end
    if bearish_engulfing then
        plot_shape(true, "Bearish Engulfing", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Bear Engulf", bearish_color)
    end
    if dark_cloud_cover then
        plot_shape(true, "Dark Cloud Cover", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Dark Cloud", bearish_color)
    end
    if bearish_harami then
        plot_shape(true, "Bearish Harami", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Bear Harami", bearish_color)
    end
    if bearish_harami_cross then
        plot_shape(true, "Bearish Harami Cross", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Bear H Cross", bearish_color)
    end
    if tweezer_top then
        plot_shape(true, "Tweezer Top", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Tweezer Top", bearish_color)
    end
    if bearish_kicker then
        plot_shape(true, "Bearish Kicker", shape_style.triangledown, shape_size.large, bearish_color, shape_location.abovebar, 0, "Bear Kicker", bearish_color)
    end
end

-- Neutral Patterns
if neutral_visible then
    if doji and not (dragonfly_doji or gravestone_doji or long_legged_doji) then
        plot_shape(true, "Doji", shape_style.circle, shape_size.large, neutral_color, shape_location.absolute, 0, "Doji", neutral_color)
    end
    if long_legged_doji then
        plot_shape(true, "Long Legged Doji", shape_style.circle, shape_size.large, neutral_color, shape_location.absolute, 0, "Long Doji", neutral_color)
    end
    if spinning_top then
        plot_shape(true, "Spinning Top", shape_style.circle, shape_size.large, neutral_color, shape_location.absolute, 0, "Spin Top", neutral_color)
    end
end
