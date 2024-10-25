--
repeat wait() until game:IsLoaded()

shared.import = function(path)
    local import
            
    local success, res = pcall(function()
        if isfolder(shared.repo) and isfile(shared.repo..'/'..path) then 
            import = loadstring(
                readfile(shared.repo..'/'..path)
            )()
        else
            if not isfolder(shared.repo) then makefolder(shared.repo) end

            writefile(shared.repo..'/'..path, game:HttpGetAsync(
                ("https://raw.githubusercontent.com/%s/%s/%s"):format(shared.user, shared.repo, path)
            ))

            import = loadstring(
                        readfile(shared.repo..'/'..path)
                    )()
        end
    end)

    if not success then error(res) end 

    return import
end

shared.info = function(...)
    if shared.debugMode == true then return print('[DEBUG]',...) end
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

local isoCodes = shared.import('modules/isoCodes.lua')
shared.info('Currently supported isoCodes:', shared.HttpService:JSONEncode(shared.isoCodes))

shared.currentISOin = 'en' -- DEFAULT ENGLISH ISO
shared.translateIn = true
shared.currentISOout = 'en' -- DEFAULT ENGLISH ISO
shared.translateOut = true 

local Translator = shared.import('modules/Translator.lua')
shared.Translator = Translator

local TestRequest = shared.Translator.Translate('Hallo', shared.currentISOout)
if TestRequest == 'error' then 
    error('Translation does not seem to work right now!')
end

shared.info('Translation is imported and working!')

local ChatHandler = shared.import('modules/ChatHandler.lua')

shared.info('Starting hooks...')

function hookmetamethod(obj, met, func)
    setreadonly(getrawmetatable(game), false)
    local old = getrawmetatable(game).__namecall
    getrawmetatable(game).__namecall = newcclosure(function(self, ...)
        local args = {...}
        if getnamecallmethod() == met and self == obj and not checkcaller() and shared.pending == false then
            return func(unpack(args))
        end
        return old(self, ...)
    end)
    setreadonly(getrawmetatable(game), true)
end


if shared.Players.LocalPlayer.PlayerGui:FindFirstChild('Chat') then 
    local events = shared.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    local sayMessageRequest = events:FindFirstChild('SayMessageRequest') 
    assert(events, 'Chat events were not found!')
    assert(sayMessageRequest, 'Chat events were not found!')

    shared.info('Game is using old chat method...')

    function sayMsg(msg, to)
        shared.pending = true
        sayMessageRequest:FireServer(msg, to)
        shared.pending = false
    end

    hookmetamethod(sayMessageRequest, "FireServer", function(msg, to)
        sayMsg(msg, to)
    end)
else
    return
end