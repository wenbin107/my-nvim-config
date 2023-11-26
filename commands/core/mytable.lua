local M = {}
-- insert table2 into table1
function M.move(table1,index,table2)
  for i, v in ipairs(table2) do
    table.insert(table1, index + i - 1, v)
  end
  return table1
end


return M
