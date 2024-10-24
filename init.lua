shared.user = 'Sino1507'
shared.repo = 'Chat-Translator/main/src'
shared.entry = 'main.lua'

shared.useBloxstrapRPC = true 
shared.debugMode = true

loadstring(
    game:HttpGetAsync(
        ("https://raw.githubusercontent.com/%s/%s/%s"):format(shared.user, shared.repo, shared.entry)
    )
)()