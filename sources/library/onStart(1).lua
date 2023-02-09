-- library.onStart(1)
-- define key functions for use elsewhere
---
function roundUpToPrecision(valueToRound)
    if valueToRound == nil then return 0 end
    local roundedValue = (math.ceil(valueToRound * precisionValue) / precisionValue)
    return roundedValue
    end
  
  ---
  function roundDownToPrecision(valueToRound)
    if valueToRound == nil then return 0 end
    local roundedValue = (math.floor(valueToRound * precisionValue) / precisionValue)
    return roundedValue
    end


    
--- eof ---