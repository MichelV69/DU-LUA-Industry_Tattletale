--- unit.onStart(1)
wss_software ={}
wss_software.id = "industry_tattletale"
wss_software.title = "Industry Tattletale"
wss_software.version = "1.0.3"
wss_software.revision = "11 feb 2023 08h55 AST"
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
local lclFontName= "Montserrat-Light" --export
FontName=[["]].. lclFontName ..[["]]
FontSize= 20 --export

---
local possibleScreens = {Screen1, Screen2, Screen3, Screen4, Screen5}
local possibleIndustries = {Industry1, Industry2, Industry3, Industry4, Industry5}
screenList = {}
industryList = {}
industryStatusData = {}

for i = 1, 5, 1 do
    if possibleScreens[i] ~= nil then
        table.insert(screenList,  possibleScreens[i])
    end
    if possibleIndustries[i] ~= nil then
        table.insert(industryList,  possibleIndustries[i])
    end
end

if #screenList == 0 then
    error "No Screen units connected.  Cannot continue."
end

if #industryList == 0 then
    error "No Industry units connected.  Cannot continue."
end

for i = 1, #screenList, 1 do
    screenList[i].activate()
    screenList[i].setCenteredText(msgTitleAndVersion .. "\n\n BOOTING")
end

industryStatusData = UpdateIndustry(industryList)
UpdateScreens(screenList, industryStatusData)
unit.setTimer(wss_software.id, 0.5)
--- eof ---