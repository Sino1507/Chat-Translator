--
repeat wait() until game:IsLoaded()

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

local TestRequest = Translator:Translate('Hallo', shared.currentISOout)
if TestRequest == 'error' then 
    error('Translation does not seem to work right now!')
end

shared.info('Translation is imported and working!')

local ChatHandler = shared.import('modules/ChatHandler.lua')

shared.info('Starting hooks...')

if shared.Players.LocalPlayer.PlayerGui:FindFirstChild('Chat') then 
    local events = shared.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    local sayMessageRequest = events:FindFirstChild('SayMessageRequest') 
    assert(events, 'Chat events were not found!')
    assert(sayMessageRequest, 'Chat events were not found!')

    shared.info('Game is using old chat method...')

    local old_method = nil
    old_method = hookmetamethod(game, '__namecall', newcclosure(function(Self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if Self == sayMessageRequest and method == 'FireServer' then
            shared.info('Intercepted message request:',args[1],' | ',args[2])
            local output = ChatHandler:Handle(args[1])

            if output ~= nil and output ~= '' then 
                return old_method(Self, output, args[2] or 'All')
            else
                return 
            end
        end
    end))
else
    return
end