-- library.onStart(1)
-- define support functions for use elsewhere
---
function roundUpToPrecision(valueToRound)
  if valueToRound == nil then return 0 end
  local roundedValue = (math.ceil(valueToRound * PrecisionValue) / PrecisionValue)
  return roundedValue
  end
  
---
function roundDownToPrecision(valueToRound)
  if valueToRound == nil then return 0 end
  local roundedValue = (math.floor(valueToRound * PrecisionValue) / PrecisionValue)
  return roundedValue
  end

---
function screenPulseTick()
  AnimationPulseIndex = AnimationPulseIndex + 1
  if AnimationPulseIndex > #ScreenPulseTable then AnimationPulseIndex = 1 end
  return ScreenPulseTable[AnimationPulseIndex]
  end
  --- eof ---