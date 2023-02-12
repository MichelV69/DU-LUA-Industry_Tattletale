-- library.onStart(3)
-- define screen layout for use elsewhere
---
function renderScreen(currentScreenObj, 
    this_machineName, this_productName, this_otherComments, this_statusCode)
local ScreenTable = {}
local configOptions = {}

configOptions[1] = currentScreenObj
configOptions[2] = this_machineName
configOptions[3] = this_productName
configOptions[4] = this_otherComments
configOptions[5] = this_statusCode

--Parameters (1)
ScreenTable[1]=[[
    local FontName=]] .. FontName ..[[
    local FontSize=]] .. FontSize ..[[
    local S_Title="]] .. wss_software.title ..[["
    local S_Version="]] .. wss_software.version ..[["
    local S_Revision="]] .. wss_software.revision ..[["
    local timeStamp="]] .. epochTime() ..[[" 
    local notDeadYet="]] ..screenPulseTick() .. [["
    ]]

-- general layout(2)
ScreenTable[2]=[[
    --Layers
    local layers={}
    layers["background"]  = createLayer()
    layers["shading"]     = createLayer()
    layers["report_text"] = createLayer()
    layers["footer_text"] = createLayer()
    layers["header_text"] = createLayer()
    
    --util functions
    function tidy(valueToRound)
        precisionDigits = 2
        precisionValue  = 10^precisionDigits
        if valueToRound == nil then return 0 end
        local roundedValue = (math.floor(valueToRound * precisionValue) / precisionValue)
        return roundedValue
        end --- function tidy
    
    function getRowColsPosition(layout, col, row)
        if col > layout.cols_wide then col = layout.cols_wide end
        x_pos = (layout.col_width * col) + layout.margin_left
        if row > layout.rows_high then row = layout.rows_high end
        y_pos = (layout.row_height * row) + layout.margin_top
        return {x_pos = x_pos, y_pos = y_pos}
        end --- function getRowColsPosition

    function getStatusCodeWord(statusCode)
        local statusCodeTable = {}
        statusCodeTable[1] = {state="Stopped"}
        statusCodeTable[2] = {state="Pending"}
        statusCodeTable[3] = {state="Jammed"}
        statusCodeTable[4] = {state="Storage Full"}
        statusCodeTable[5] = {state="No Output"}
        statusCodeTable[6] = {state="Running"}
        statusCodeTable[7] = {state="No Schemas"}
        return statusCodeTable[statusCode].state
        end  --- function getStatusCodeWord

    --Scr Resolution
    local rx, ry=getResolution()
    local layout = {}
    layout.cols_wide = tidy(rx/(FontSize*1.2))
    layout.col_width = tidy(rx/layout.cols_wide)
    
    layout.rows_high = tidy(ry/(FontSize*1.2))
    layout.row_height = tidy(ry/layout.rows_high)
    
    layout.margin_top = tidy((ry * 0.1) / 2)
    layout.margin_bottom = layout.margin_top
    layout.margin_left = tidy((rx * 0.1) / 2)
    layout.margin_right = layout.margin_left
    
    --Font Setups
    local offsetStepPX = 24
    local fontSizeStep = 0.33
    local FontText=loadFont(FontName , FontSize)
    local FontTextSmaller=loadFont(FontName , FontSize * (1 - fontSizeStep))
    local FontTextBigger=loadFont(FontName , FontSize * (1 + fontSizeStep))
]]

--get data to publish (3)
ScreenTable[3]=[[

    local this_machineName = ']] .. configOptions[2] .. [['
    local this_productName = ']] .. configOptions[3] .. [['
    local this_otherComments = ']] .. configOptions[4] .. [['
    local this_statusCode = getStatusCodeWord(]] .. configOptions[5] .. [[)

]]

-- header and footer (4)
ScreenTable[4]=[[
  local vpos = 1
  publish_to = getRowColsPosition(layout, 1, vpos)
  textMessage = S_Title .. " v" .. S_Version .. " (" .. S_Revision .. ")"
  addText(layers["header_text"], FontTextSmaller, textMessage, publish_to.x_pos, publish_to.y_pos)

  col = tidy(layout.cols_wide/3)
  row = layout.rows_high - 3

  publish_to = getRowColsPosition(layout, col, row)
  textMessage = "screen last updated: ["..timeStamp.."]"
  addText(layers["footer_text"], FontTextSmaller, textMessage, publish_to.x_pos, publish_to.y_pos)
]]

--- format data for display
ScreenTable[5]=[[ 
        eightCols = tidy(layout.cols_wide/8)
        row = layout.rows_high /3

        publish_to = getRowColsPosition(layout, eightCols, row)
        textMessage = this_machineName   
        addText(layers["report_text"], FontTextBigger, textMessage, publish_to.x_pos, publish_to.y_pos)

        horiz_offset = 1
        vert_offset = 2
        publish_to = getRowColsPosition(layout, eightCols * horiz_offset, row + vert_offset)

        textMessage = this_statusCode
        addText(layers["report_text"], FontTextBigger, textMessage, publish_to.x_pos, publish_to.y_pos)

        horiz_offset = 2
        vert_offset = 3
        publish_to = getRowColsPosition(layout, eightCols * horiz_offset, row + vert_offset)
        textMessage = this_productName
        addText(layers["report_text"], FontText, textMessage, publish_to.x_pos, publish_to.y_pos)

        horiz_offset = 2
        vert_offset = 4
        publish_to = getRowColsPosition(layout, eightCols * horiz_offset, row + vert_offset)
        textMessage = this_otherComments
        addText(layers["report_text"], FontText, textMessage, publish_to.x_pos, publish_to.y_pos)

        ]]

--- tick-timer, etc (6)
ScreenTable[6]=[[
  col = tidy(layout.cols_wide/3)
  row = layout.rows_high - 4
  publish_to = getRowColsPosition(layout, col, row)
  textMessage = notDeadYet
  addText(layers["report_text"], FontText, textMessage, publish_to.x_pos, publish_to.y_pos)  
  ]]

--Animation (7)
ScreenTable[7]=[[
    requestAnimationFrame(5)
    ]]

--RENDER
function ScreenRender(configOptions)
    local screenTemplate = table.concat(ScreenTable)
    configOptions[1].setRenderScript(screenTemplate)
    end -- function ScreenRender

ScreenRender(configOptions)
end -- function renderScreen
---
--- eof ---