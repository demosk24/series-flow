instrument { name = 'CoPilot', icon = '', overlay = true }

--===EMA ================================= 
ema20=ema(close,20)
ema50=ema(close,50)
ema100=ema(close,100)
ema200=ema(close,200)

--===BB ================================= 
base = sma(close,20)
upperBand2dev=base+ (stdev(close,20)*2)
lowerBand2dev=base- (stdev(close,20)*2)
upperBand1dev=base+ (stdev(close,20)*1)
lowerBand1dev=base- (stdev(close,20)*1)

--===ZIGZAG =================================
percentage = 1 /100
period = 3
up_color  = rgba(50, 205, 50,0.3)
down_color = rgba(255, 87, 51,0.3)

local reference = make_series ()
reference:set(nz(reference[1], high))

local is_direction_up = make_series ()
is_direction_up:set(nz(is_direction_up[1], true))

local htrack = make_series ()
local ltrack = make_series ()

local pivot = make_series ()

reverse_range = reference * percentage / 100

if get_value (is_direction_up) then
    htrack:set (max(high, nz(htrack[1], high)))

    if close < htrack[1] - reverse_range then
        pivot:set (htrack)
        is_direction_up:set (false)
        reference:set(htrack)
    end
else
    ltrack:set (min(low, nz(ltrack[1], low)))

    if close > ltrack[1] + reverse_range then
        pivot:set (ltrack)
        is_direction_up:set(true)
        reference:set (ltrack)
    end
end

color = is_direction_up() and  up_color or down_color

--===NEW AREA=============================================================================
sec = security (current_ticker_id, "1m")

if (sec ~= nil) and (sec.open_time == open_time) then
 if open< close then 
    plot_candle(open,high,low,close,"BULL","#49B07C")
 elseif open > close then 
    plot_candle(open,high,low,close,"BER","#E74454")
 end
end

plot(pivot, 'ZZ', color, 1, -1, style.solid_line, na_mode.continue)

plot(ema20,'Ema20','rgba(250, 233, 33, 0.3)',0.5,0,style.solid_line)
plot(ema50,'Ema50','rgba(202, 110, 16, 0.3)',0.5,0,style.solid_line)
plot(ema100,'Ema100','rgba(177, 46, 28,0.3)',0.5,0,style.solid_line)
plot(ema200,'Ema200','rgba(135, 23, 198,0.3)',0.5,0,style.solid_line)
