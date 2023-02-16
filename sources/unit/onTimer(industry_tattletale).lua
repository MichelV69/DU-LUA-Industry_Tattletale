--- onTimer(industry_tattletale)
--- launch every 0.5 seconds
unit.stopTimer(WS2_Software.id)
IndustryStatusData = UpdateIndustry(IndustryList)
UpdateScreens(ScreenList, IndustryStatusData)
unit.setTimer(WS2_Software.id, 0.5)
--- eof --- 