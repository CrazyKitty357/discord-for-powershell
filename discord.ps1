$message = Read-Host "message"
# Define the headers using a hashtable
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "discord_user_token_here"
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"
}

# Create a web session
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# Construct the JSON body with the message variable
$body = @{
    content = "$message *(this was sent from PowerShell)*"
} | ConvertTo-Json

# Make the API request
$response = Invoke-RestMethod -Uri 'https://discord.com/api/v9/channels/channel_id/messages' -Method POST -Headers $headers -WebSession $session -ContentType 'application/json' -Body $body
Pause
