# Chat Translator

A Roblox Lua script that automatically translates player chat messages to make cross-language communication easy and accessible in your game.

## Features

- **Automatic Translation**: Instantly translates player chat messages from their original language to a specified target language.
- **Customizable Target Language**: Choose the target language for translation based on game or player preferences.
- **User-Friendly**: Simple setup and intuitive use; seamlessly integrates into existing Roblox games.
- **Supports Multiple Languages**: Compatible with multiple languages through integration with translation APIs.


## Script

```lua
--[[
    Creator: SinoXde
    Working as of: 10/20/2024
    Supports (Tested): Wave

    This Script falls under the MIT License:

    Copyright (c) 2024 SinoXde

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
]]

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
```

## How to Use

1. **Copy Script**: Copy the above script and paste it in your exploit.

### Commands
- **`>set in/out on/off`**: Toggles whether Input/Output translation is enabled.
- **`>in/out ISOCODE`**: Sets the Input/Output language to the specified ISO code.

*Note*: If you encounter an error, it may mean either your exploit is not supported, or the game you are using the script on has a custom ChatHandler.

## Version

- **Current Version**: Pre-Release
- **Release Date**: [Unknown]
- **Changes**:
  - Initial release with basic chat translation functionality

