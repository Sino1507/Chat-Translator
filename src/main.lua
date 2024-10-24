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

shared.info = function(args)
    if shared.debugMode then return print('[DEBUG]',args) end
end

local Services = shared.import('modules/Services.lua')
Services:GetServices(
    {
        'HttpService',
        'Players',
        'Workspace',
        'ReplicatedStorage'
    }
)

local BloxstrapRPC = shared.import('modules/BloxstrapRPC.lua')
shared.BloxstrapRPC = BloxstrapRPC

local Connections = shared.import('modules/Connections.lua')

local ExploitSupport = shared.import('modules/ExploitSupport.lua')

if not ExploitSupport:Test(hookmetamethod, false) or not ExploitSupport:Test(hookfunction, false) or not ExploitSupport:Test(request, false) then
    error('Exploit is not supported!')
end

shared.info('Everything mandetory is now imported. Beginning...')

local isoCodes = import('modules/isoCodes.lua')
shared.info('Currently supported isoCodes:', shared.HttpService:JSONEncode(shared.isoCodes))