--
shared.import = function(path)
    local import
    
    local success, res = pcall(function()
        import = loadstring(
                    game:HttpGetAsync(
                        ("https://raw.githubusercontent.com/%s/%s/%s"):format(shared.user, shared.repo, path)
                    )
                )()
    end)

    if not success then error(res) end 

    return import
end

local TestModule = shared.import('modules/blank.lua')

TestModule:Test()