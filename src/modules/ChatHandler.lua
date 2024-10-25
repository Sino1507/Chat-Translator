local ChatHandler = {}
shared.prefix = '>'

function ChatHandler:ValidISO(input)
    return table.find(shared.isoCodes, input) ~= nil
end

function ChatHandler:ChatNotify(message, color, Size)
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = message,
        Color = color or Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.SourceSans,
        FontSize = Size or Enum.FontSize.Size48
    })
end

function ChatHandler:GetState(arg)
    local pos = {
        'on',
        'true',
        '1'
    }

    return table.find(pos, string.lower(arg)) ~= nil
end

function ChatHandler:HandleCommand(input)
    input = string.gsub(input, '>', '')
    local args = string.split(input, ' ')
    local command = string.lower(args[1])
    table.remove(args, 1)

    if command == 'out' and ChatHandler:ValidISO(string.lower(args[1])) then
        shared.currentISOout = string.lower(args[1])
        shared.info('Output language has been set to:',shared.currentISOout)
    end

    if command == 'in' and ChatHandler:ValidISO(string.lower(args[1])) then
        shared.currentISOin = string.lower(args[1])
        shared.info('Output language has been set to:',shared.currentISOin)
    end

    if command == 'set' and (string.lower(args[1]) == ('in' or 'out')) then 
        local state = ChatHandler:GetState(args[2])
        if state == nil then return end 

        if string.lower(args[1]) == 'in' then shared.translateIn = state else shared.translateOut = state end
        shared.info(string.lower(args[1]),'has been set to',tostring(state))
    end
end

function ChatHandler:HandleTranslation(message, isself)
    shared.info('Got HandleTranslation request:',message,' | ',tostring(isself))
    if shared.Translator == nil then error('Unable to get Translator!') end
    isself = isself or true

    if isself and shared.translateOut then 
        message = shared.Translator:Translate(message, shared.currentISOout)
    elseif isself == false and shared.translateIn then
        message = shared.Translator:Translate(message, shared.currentISOin)
    end

    return message
end

function ChatHandler:Handle(message, speaker)
    local result = nil
    local isCommand = string.sub(message, 1, 1) == '>'
    local isSelf = speaker and shared.Players.LocalPlayer == speaker or true

    if isCommand then 
        ChatHandler:HandleCommand(message)
    else
        result = ChatHandler:HandleTranslation(message, isSelf)
    end

    return result
end


return ChatHandler