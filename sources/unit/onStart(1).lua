--- unit.onStart(1)
WS2_Software = {}
WS2_Software.id = "industry_tattletale"
WS2_Software.title = "Industry Tattletale"
WS2_Software.version = "1.0.8"
WS2_Software.revision = "15 feb 2023 20h58 AST"
WS2_Software.author = "Michel Vaillancourt <902pe_gaming@wolfstar.ca>"

system.print("\n --------------- \n")
local msgTitleAndVersion = WS2_Software.title .. "\n" .. WS2_Software.version
system.print(msgTitleAndVersion)

---
PrecisionDigits          = 2
PrecisionValue           = 10 ^ PrecisionDigits
GramsToKG                = 1000
Minutes                  = {}
Minutes[1]               = 60
Minutes[2]               = Minutes[1] * 2
Minutes[5]               = Minutes[1] * 5

ScreenPulseTable         = {}
ScreenPulseTable[1]      = "[-=+     ]"
ScreenPulseTable[2]      = "[ -=+    ]"
ScreenPulseTable[3]      = "[  -=+   ]"
ScreenPulseTable[4]      = "[   -=+  ]"
ScreenPulseTable[5]      = "[    -=+ ]"
ScreenPulseTable[6]      = "[     -=+]"
ScreenPulseTable[7]      = "[     -+=]"
ScreenPulseTable[8]      = "[     +=-]"
ScreenPulseTable[9]      = "[    +=- ]"
ScreenPulseTable[10]     = "[   +=-  ]"
ScreenPulseTable[11]     = "[  +=-   ]"
ScreenPulseTable[12]     = "[ +=-    ]"
ScreenPulseTable[13]     = "[+=-     ]"
ScreenPulseTable[14]     = "[=+-     ]"
ScreenPulseTable[15]     = "[=-+     ]"
AnimationPulseIndex      = 1

---
local lclFontName        = "Montserrat-Light" --export
FontName                 = [["]] .. lclFontName .. [["]]
FontSize                 = 32 --export

---
local possibleScreens    = { Screen1, Screen2, Screen3, Screen4 }
local possibleIndustries = { Industry1, Industry2, Industry3, Industry4 }
ScreenList               = {}
IndustryList             = {}
IndustryStatusData       = {}

for i = 1, 5, 1 do
    if possibleScreens[i] ~= nil then
        table.insert(ScreenList, possibleScreens[i])
    end
    if possibleIndustries[i] ~= nil then
        table.insert(IndustryList, possibleIndustries[i])
    end
end

if #ScreenList == 0 then
    error "No Screen units connected.  Cannot continue."
else
    system.print(WS2_Software.id .. ": found [" .. #ScreenList .. "] connected ScreenUnits.")
end

if #IndustryList == 0 then
    error "No Industry units connected.  Cannot continue."
else
    system.print(WS2_Software.id .. ": found [" .. #IndustryList .. "] connected IndustryUnits.")
end

for i = 1, #ScreenList, 1 do
    ScreenList[i].activate()
    ScreenList[i].setCenteredText(msgTitleAndVersion .. "\n\n BOOTING")
end

IndustryStatusData = UpdateIndustry(IndustryList)
UpdateScreens(ScreenList, IndustryStatusData)
unit.setTimer(WS2_Software.id, 0.5)
--- eof ---
