instrument {
    name = 'TD Sequent',
    icon = '',
    overlay = true
}

TDU = iff(close > close[4], TDU[1] + 1 ,0)
TDUp = get_value(TDU)

--print(TDUp)

TDD = iff(close < close[4], TDD[1] + 1, 0)
TDDn = get_value(TDD)


TDUp1 = iff(TDUp == 1, true, false)
TDUp2 = iff(TDUp == 2, true, false)
TDUp3 = iff(TDUp == 3, true, false)
TDUp4 = iff(TDUp == 4, true, false)
TDUp5 = iff(TDUp == 5, true, false)
TDUp6 = iff(TDUp == 6, true, false)
TDUp7 = iff(TDUp == 7, true, false)
TDUp8 = iff(TDUp == 8, true, false)
TDUp9 = iff(TDUp == 9, true, false)

plot_shape(TDUp1 == true, "Up1", shape_style.cross, shape_size.auto, "green", shape_location.abovebar, 0, "1", "green")
plot_shape(TDUp2 == true, "Up2", shape_style.cross, shape_size.auto, "green", shape_location.abovebar, 0, "2", "green")
plot_shape(TDUp3 == true, "Up3", shape_style.cross, shape_size.auto, "green", shape_location.abovebar, 0, "3", "green")
plot_shape(TDUp4 == true, "Up4", shape_style.cross, shape_size.auto, "green", shape_location.abovebar, 0, "4", "green")
plot_shape(TDUp5 == true, "Up5", shape_style.cross, shape_size.auto, "green", shape_location.abovebar, 0, "5", "green")
plot_shape(TDUp6 == true, "Up6", shape_style.cross, shape_size.auto, "green", shape_location.abovebar, 0, "6", "green")
plot_shape(TDUp7 == true, "Up7", shape_style.cross, shape_size.auto, "green", shape_location.abovebar, 0, "7", "green")
plot_shape(TDUp8 == true, "Up8", shape_style.cross, shape_size.auto, "green", shape_location.abovebar, 0, "8", "green")
plot_shape(TDUp9 == true, "Up9", shape_style.cross, shape_size.auto, "green", shape_location.abovebar, 0, "9", "green")


TDDn1 = iff(TDDn == 1, true, false)
TDDn2 = iff(TDDn == 2, true, false)
TDDn3 = iff(TDDn == 3, true, false)
TDDn4 = iff(TDDn == 4, true, false)
TDDn5 = iff(TDDn == 5, true, false)
TDDn6 = iff(TDDn == 6, true, false)
TDDn7 = iff(TDDn == 7, true, false)
TDDn8 = iff(TDDn == 8, true, false)
TDDn9 = iff(TDDn == 9, true, false)

plot_shape(TDDn1 == true, "Dn1", shape_style.cross, shape_size.auto, "red", shape_location.belowbar, 0, "1", "red")
plot_shape(TDDn2 == true, "Dn2", shape_style.cross, shape_size.auto, "red", shape_location.belowbar, 0, "2", "red")
plot_shape(TDDn3 == true, "Dn3", shape_style.cross, shape_size.auto, "red", shape_location.belowbar, 0, "3", "red")
plot_shape(TDDn4 == true, "Dn4", shape_style.cross, shape_size.auto, "red", shape_location.belowbar, 0, "4", "red")
plot_shape(TDDn5 == true, "Dn5", shape_style.cross, shape_size.auto, "red", shape_location.belowbar, 0, "5", "red")
plot_shape(TDDn6 == true, "Dn6", shape_style.cross, shape_size.auto, "red", shape_location.belowbar, 0, "6", "red")
plot_shape(TDDn7 == true, "Dn7", shape_style.cross, shape_size.auto, "red", shape_location.belowbar, 0, "7", "red")
plot_shape(TDDn8 == true, "Dn8", shape_style.cross, shape_size.auto, "red", shape_location.belowbar, 0, "8", "red")
plot_shape(TDDn9 == true, "Dn9", shape_style.cross, shape_size.auto, "red", shape_location.belowbar, 0, "9", "red")

-- TD Line --

SellSetup = close > close[4] and TDUp == 9
SellHigh = value_when(SellSetup, max(max(high,high[1]),max(high[2],high[3])), 0)
SellLow = value_when(SellSetup, min(min(low[8],low[7]),min(low[6],low[5])), 0)

plot(iff(SellHigh,SellHigh,na(SellHigh)), "TDLSS9", "green", 2, 0, style.points)
plot(iff(SellLow,SellLow,na(SellLow)),"TDLSS1", "aqual", 1, 0, style.solid_line)


BuySetup = close < close[4] and TDDn == 9
BuyLow = value_when(BuySetup, min(min(low,low[1]),min(low[2],low[3])), 0)
BuyHigh = value_when(BuySetup, max(max(high[8],high[7]),max(high[6],high[5])), 0)

plot(iff(BuyLow,BuyLow,na(BuyLow)), "TDLBS9", "red", 2, 0, style.points)
plot(iff(BuyHigh,BuyHigh,na(BuyHigh)),"TDLBS1", "magenta", 1, 0, style.solid_line)
