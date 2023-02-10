--- unit.onStart(1)
wss_software ={}
wss_software.id = "industry_tattletale"
wss_software.title = "Industry Tattletale"
wss_software.version = "1.0.1"
wss_software.revision = "09 feb 2023 10h38 AST"
wss_software.author = "Michel Vaillancourt <902pe_gaming@wolfstar.ca>"

system.print("\n --------------- \n")
local msgTitleAndVersion = wss_software.title .. "\n" .. wss_software.version
system.print(msgTitleAndVersion)

---
precisionDigits = 2
precisionValue  = 10^precisionDigits
gramsToKG = 1000
minutes = {}
minutes[1] = 60
minutes[2] = minutes[1]*2
minutes[5] = minutes[1]*5

statusCodeTable = {}
statusCodeTable[1] = {state="Stopped"}
statusCodeTable[2] = {state="Pending"}
statusCodeTable[3] = {state="Jammed"}
statusCodeTable[4] = {state="Storage Full"}
statusCodeTable[5] = {state="No Output"}
statusCodeTable[6] = {state="Running"}
statusCodeTable[7] = {state="No Schemas"}

screenPulseTable = {}
screenPulseTable[1]  = "[-=+     ]"
screenPulseTable[2]  = "[ -=+    ]"
screenPulseTable[3]  = "[  -=+   ]"
screenPulseTable[4]  = "[   -=+  ]"
screenPulseTable[5]  = "[    -=+ ]"
screenPulseTable[6]  = "[     -=+]"
screenPulseTable[7]  = "[     -+=]"
screenPulseTable[8]  = "[     +=-]"
screenPulseTable[9]  = "[    +=- ]"
screenPulseTable[10] = "[   +=-  ]"
screenPulseTable[11] = "[  +=-   ]"
screenPulseTable[12] = "[ +=-    ]"
screenPulseTable[13] = "[+=-     ]"
screenPulseTable[14] = "[=+-     ]"
screenPulseTable[15] = "[=-+     ]"
animationPulseIndex = 1

---
local ScreenList = {}
local IndustryList = {}
local industryStatusData = {} --- struct = name, statusCode, workingOn, errorDetails, otherNotes
for i = 1, 5, 1 do
    if Screen[i] then
        ScreenList[1] = Screen[i]
    end
    if Industry[i] then
        IndustryList[1] = Industry[i]
    end
end

if #ScreenList == 0 then
    error "No Screen units connected.  Cannot continue."
end

if #IndustryList == 0 then
    error "No Industry units connected.  Cannot continue."
end

for i = 1, #ScreenList, 1 do
    ScreenList[i].activate()
    ScreenList[i].setCenteredText(msgTitleAndVersion .. "\n\n BOOTING")
end

industryStatusData = UpdateIndustry(IndustryList)
UpdateScreens(ScreenList, IndustryStatusData)
--- eof ---