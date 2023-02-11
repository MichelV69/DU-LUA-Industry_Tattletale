--- onTimer(industry_tattletale)
--- launch every 0.5 seconds
unit.stopTimer(wss_software.id)
UpdateScreens(screenList, industryStatusData)
unit.setTimer(wss_software.id, 0.5)
--- eof --- 