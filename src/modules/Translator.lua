local Translator = {}
shared.Translator = Translator

function Translator:Encode(str)
    str = str:gsub('([^%w%-%.%_%~])', function(c)
        return string.format('%%%02X', string.byte(c))
    end)

    return str
end

function Translator:Translate(input)
    shared.info('Got translation request:',input,' |',shared.currentISO)
    local enc = Translator:Encode(input)
    local req = request({
        Url = 'https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=' .. shared.currentISO .. '&dt=t&q=' .. enc,
        Method = 'GET'
    })

    if req and req.StatusCode == 200 then
        local response = shared.HttpService:JSONDecode(req.body)
        if response then
            local translations = response[1] 
            local fullTranslation = ''
            
            for _, translation in ipairs(translations) do
                fullTranslation = fullTranslation .. translation[1]
            end

            shared.info('Translated',input,'to',fullTranslation)
            return fullTranslation:match('^%s*(.-)%s*$')
        else
            shared.info('There was a critical error while translating:', req.StatusCode, req.body)
        end
    else
        shared.info('Google seems unreachable at the time')
    end
    
    return 'error'
end

return Translator