# Set the current theme as variables
$initialForegroundColor = $host.ui.RawUI.ForegroundColor
$initialBackgroundColor = $host.ui.RawUI.BackgroundColor

# Prompt the user when they do not have a discord token
if (Get-Item "Token.txt" -ErrorAction SilentlyContinue) {} else {
    Write-Host "You do not have a discord account token"
    Write-Host "You NEED one for this application to work"
    $tokenprompt = Read-Host "Would you like to get one? [Y/N]"
    if ($tokenprompt -eq "Y") {
        Write-Host ""
        Write-Host "Step 1: You can get your discord token by going to https://discord.com/app"
        Write-Host "Step 2: from there open up inspect element, then click on the network tab"
        Write-Host "Step 3: Reload the page"
        Write-Host "Step 4: In filter type /api then click on library"
        Write-Host "Step 5: In library click on headers, scroll down to authorization."
        Write-Host "Step 6: Everything in authorization is your discord token, so copy it and paste it into this application"
        Write-Host ""
        $newtoken = Read-Host "Paste your token"
        $tokenconf = Read-Host "are you sure $newtoken is your discord token? [Y/N]"
        if ($tokenconf -eq "Y") {
            Write-Host "[SYSTEM] MAKING FILE"
            $newtoken | Out-File Token.txt
        }
    }
    Pause
}
$token = Get-Content "Token.txt" -ErrorAction SilentlyContinue # DO NOT MAKE THIS A BOT TOKEN, THIS HAS TO BE AN ACCOUNT TOKEN

#assign custom variables
$signature = "*(this was sent from PowerShell)*"

# Define the headers using a hashtable
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "$token"
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"
}

# Initialize the message and channel variables
$message = ""
$channel = "" # this is the default channel that will open up every time you open this application up


# Read emotes from the text file
$emotesFilePath = "Emotes.txt"
$emotes = @{}
Get-Content $emotesFilePath | ForEach-Object {
    $name, $url = ($_ -split ' ', 2)
    $emotes[$name] = $url
}

# Loop until the user types "/quit"
do {
    # User writes their message and saves it as a variable
    Clear-Host
    Write-Host "PowerShell Discord client by CrazyKitty357"
    Write-Host ""
    if ($channel -eq "") {
        Write-Host "Current Channel: NO CHANNEL"
    } else {
        Write-Host "Current Channel: $channel"
    }
    Write-Host "You can view all commands by typing '/commands'"
    $message = Read-Host "message"

    # Check if the user wants to quit
    if ($message -ne "/quit") {
        # Check if the user wants to change the channel
        if ($message -eq "/channel") {
            $channel = Read-Host "Enter the new channel ID"
            continue
        }
# Check if the user wants to print their discord token
elseif ($message -eq "/token") {
    Clear-Host
    Write-Host "Your Discord token is $token"
    Pause
    continue
}
elseif ($message -eq "/quit") {
    Clear-Host
    exit
}
# Check if the user wants to see all of the commands
elseif ($message -eq "/commands") {
    Clear-Host
    Write-Host "/COMMANDS | shows all commands"
    Write-Host ""
    Write-Host "/quit | closes the application"
    Write-Host "/channel | changes the active channel"
    Write-Host "/token | views your current discord token"
    Write-Host "/emotes | shows all usable emotes, you can edit them via Emotes.txt"
    Write-Host "/themes | you can change the theme of the current powershell terminal"
    Write-Host "/SaveTheme | saves the theme as 2 txt files, this was used for debugging themes"
    Pause
    continue
}
elseif ($message -eq "/SaveTheme") {
    # Reset colors to initial state
    $host.ui.RawUI.ForegroundColor = $initialForegroundColor
    $host.ui.RawUI.BackgroundColor = $initialBackgroundColor
    $initialForegroundColor | Out-File FG.txt
    $initialBackgroundColor | Out-File BG.txt
}
elseif ($message -eq "/themes") {
    # Go to themes
    $scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "theme.ps1"
& $scriptPath
}
# Check if the user wants to use emotes
elseif ($message -eq "/emotes") {
    # Display available emotes
    Write-Host "Available Emotes:"
    $emotes.Keys | ForEach-Object {
        Write-Host "$_"
    }
    # Prompt the user to choose an emote
    $emoteName = Read-Host "Enter the name of the emote you want to use"
    if ($emotes.ContainsKey($emoteName)) {
        # Use the selected emote's URL as the message
        $message = $emotes[$emoteName]
        # Make the API request without using ConvertTo-Json for this specific case
        $body = @{
            content = $message
        }

        # Make the API request
        $response = Invoke-RestMethod -Uri "https://discord.com/api/v9/channels/$channel/messages" -Method POST -Headers $headers -WebSession $session -ContentType 'application/json' -Body ($body | ConvertTo-Json)
        # Construct the JSON body with the message variable
        $body = @{
            content = $signature
        } | ConvertTo-Json

        # Make the API request
        $response = Invoke-RestMethod -Uri "https://discord.com/api/v9/channels/$channel/messages" -Method POST -Headers $headers -WebSession $session -ContentType 'application/json' -Body $body
    } else {
        Write-Host "Invalid emote name. Please choose a valid emote."
    }
    continue
}


        # Construct the JSON body with the message variable
        $body = @{
            content = "$message $signature"
        } | ConvertTo-Json

        # Make the API request
        $response = Invoke-RestMethod -Uri "https://discord.com/api/v9/channels/$channel/messages" -Method POST -Headers $headers -WebSession $session -ContentType 'application/json' -Body $body
    }
} while ($message -ne "/quit")