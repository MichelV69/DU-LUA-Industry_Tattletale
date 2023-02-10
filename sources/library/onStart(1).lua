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

---
function UpdateIndustry(table_IndustryList)
  local lclIndustryStatusData = {}
  local aRecord = {}

  for index, machinery in pairs(table_IndustryList) do
    local this_machine_info = {} 
    this_machine_info.state = machinery.getInfo()[1]
    this_machine_info.stopRequested = machinery.getInfo()[2]
    this_machine_info.deprecated = machinery.getInfo()[3]
    this_machine_info.schematicsRemaining = machinery.getInfo()[4]
    this_machine_info.unitsProduced = machinery.getInfo()[5]
    this_machine_info.remainingTime = machinery.getInfo()[6]
    this_machine_info.batchesRequested = machinery.getInfo()[7]
    this_machine_info.batchesRemaining = machinery.getInfo()[8]
    this_machine_info.maintainProductAmount = machinery.getInfo()[9]
    this_machine_info.currentProductAmount = machinery.getInfo()[10]
    this_machine_info.currentProductID = machinery.getInfo()[11][1]
    
    aRecord = {machineName = machinery.getName(), 
      state_code = this_machine_info.state, 
      schematicsRemaining = this_machine_info.schematicsRemaining,
      currentProductID = this_machine_info.currentProductID, 
      remainingTimeOnCycle = this_machine_info.remainingTime, 
      otherComments = ""}

    if this_machine_info.batchesRequested then
      otherComments = otherComments .. "Running In Batch Mode"
      end
    if this_machine_info.maintainProductAmount then
      otherComments = otherComments .. "Running In Inventory Maintenance Mode"
      end

    table.insert(lclIndustryStatusData, aRecord)
    end --- for index

  return lclIndustryStatusData
  end --- function

function UpdateScreens(lclScreenList, lclIndustryList)
  return true
  end --- function
--- eof ---