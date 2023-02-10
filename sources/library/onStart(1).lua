-- library.onStart(1)
-- define support functions for use elsewhere
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

---
function screenPulseTick()
  animationPulseIndex = animationPulseIndex + 1
  if animationPulseIndex > #screenPulseTable then animationPulseIndex = 1 end
  return screenPulseTable[animationPulseIndex]
  end
  --- eof ---