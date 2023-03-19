local mt = getrawmetatable(game)
make_writeable(mt)
local namecall = mt.__namecall
mt.__namecall = newcclosure( function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "FireServer" and args[1] == "CHECKER_1" then
        return wait(9e9)
    end
    return namecall(self, ...)
end)