-- library.onStart(2)
-- define key functions for use elsewhere
---
function UpdateIndustry(table_IndustryList)
    local lclIndustryStatusData = {}

    for i = 1, #table_IndustryList, 1 do
      local aRecord = {}
      if table_IndustryList[i] ~= nil then 
            
          local status_table = table_IndustryList[i].getInfo()

          aRecord["machineName"] = table_IndustryList[i].getName()
          local product_id = status_table.currentProducts[1].id
          aRecord["product_name"] = system.getItem(product_id).locDisplayNameWithSize
          aRecord["product_iconPath"] = system.getItem(product_id).iconPath
          aRecord["status_code"]  = status_table.state
          aRecord["otherComments"] = "---"
            
          if aRecord["status_code"] == 1 then
             aRecord["otherComments"] = status_table.batchesRemaining
                .. " batches Remaining"
                .. " of "
                .. status_table.batchesRequested
                .. " batches Requested."
             end --- if aRecord["status_code"]  
            
          if aRecord["status_code"] == 2 then
             aRecord["otherComments"] = "time Remaining on current run: " .. status_table.remainingTime
             end --- if aRecord["status_code"]

          if aRecord["status_code"] == 6 
             and status_table.maintainProductAmount > 0
             then
                 aRecord["otherComments"] = "maintain Product Amount: " .. status_table.maintainProductAmount
                 end --- if aRecord["status_code"]
            
          lclIndustryStatusData[i] = aRecord
          end --- if machinery
      end   --- for i 
  
    return lclIndustryStatusData
    end --- function

---
function UpdateScreens(lcl_ScreenList, lcl_IndustryStatusData)
 
  for i = 1, #lcl_ScreenList, 1 do
        renderScreen(
            lcl_ScreenList[i], 
            lcl_IndustryStatusData[i].machineName, 
            lcl_IndustryStatusData[i].product_name,
            lcl_IndustryStatusData[i].otherComments, 
            lcl_IndustryStatusData[i].status_code,
            lcl_IndustryStatusData[i].product_iconPath
        )
     end
  end --- function
--- eof ---
