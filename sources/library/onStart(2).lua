-- library.onStart(2)
-- define key functions for use elsewhere
---
function UpdateIndustry(table_IndustryList)
  local lclIndustryStatusData = {}

  for i = 1, #table_IndustryList, 1 do
    local aRecord = {}
    if table_IndustryList[i] ~= nil then 
          
        local status_table = table_IndustryList[i].getInfo()
        otherComments = "simple test data."

        aRecord["machineName"] = table_IndustryList[i].getName()
        local product_id = status_table.currentProducts[1].id
        aRecord["product_name"] = system.getItem(product_id).locDisplayNameWithSize
        aRecord["status_code"]  = status_table.state
        aRecord["otherComments"] = otherComments
          
        lclIndustryStatusData[i] = aRecord
        end --- if machinery
    end   --- for i 

  return lclIndustryStatusData
  end --- function

---
function UpdateScreens(lcl_ScreenList, lcl_IndustryStatusData)
---system.print(wss_software.id 
---              .. "|lcl_ScreenList #"
---              .. #lcl_ScreenList
---      )
 
for i = 1, #lcl_ScreenList, 1 do
      ---system.print(wss_software.id 
      ---  .. lcl_ScreenList[i].getName()
      ---)
      renderScreen(
          lcl_ScreenList[i], 
          lcl_IndustryStatusData[i].machineName, 
          lcl_IndustryStatusData[i].product_name, 
          lcl_IndustryStatusData[i].otherComments, 
          lcl_IndustryStatusData[i].status_code
      )
   end
end --- function
--- eof ---