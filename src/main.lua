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

print('Yes!')

local Services = shared.import('modules/Services.lua')
Services:GetServices(
    {
        'HttpService',
        'Players',
        'Workspace',
        'ReplicatedStorage'
    }
)

print(shared.HttpService)

local BloxstrapRPC = shared.import('modules/BloxstrapRPC.lua')
shared.BloxstrapRPC = BloxstrapRPC

BloxstrapRPC.SetRichPresence({
    details = "Testing!",
    state = 'This is a test :D!',
    largeImage = {
        assetId = 16875079348,
        hoverText = "Using something"
    },
    smallImage = {
        assetId = 6925817108,
        hoverText = shared.Players.LocalPlayer.Name
    }
})

print('Done!')