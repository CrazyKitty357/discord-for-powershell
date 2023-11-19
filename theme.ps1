param (
    [string]$Arg1
)
Clear-Host
Write-Host "THEMES"
Write-Host ""
Write-Host "DEFAULT THEMES"
Write-Host "Windows 10 Default"
Write-Host "Windows 11 Default"
Write-Host ""
Write-Host "LIGHT THEMES"
Write-Host "Light Mode Blue"
Write-Host ""
Write-Host "DARK THEMES"
Write-Host "Hackerman"
Write-Host ""
Write-Host "MEME THEMES"
Write-Host "Kahoot Wrong Anwser"
Write-Host "Kahoot Right Anwser"
Write-Host
$theme = Read-Host "What theme do you want to use?"

switch -Regex ($theme) {
    'Windows 10 Default' {
        # Define new colors
        $foregroundColor = [System.ConsoleColor]::DarkYellow
        $backgroundColor = [System.ConsoleColor]::DarkMagenta
        
        # Set console colors
        $host.ui.RawUI.ForegroundColor = $foregroundColor
        $host.ui.RawUI.BackgroundColor = $backgroundColor
        Clear-Host }
    'Windows 11 Default' {
        # Define new colors
        $foregroundColor = [System.ConsoleColor]::Gray
        $backgroundColor = [System.ConsoleColor]::Black
            
        # Set console colors
        $host.ui.RawUI.ForegroundColor = $foregroundColor
        $host.ui.RawUI.BackgroundColor = $backgroundColor
        Clear-Host }
    'Hackerman' {
        # Define new colors
        $foregroundColor = [System.ConsoleColor]::Green
        $backgroundColor = [System.ConsoleColor]::Black

        # Set console colors
        $host.ui.RawUI.ForegroundColor = $foregroundColor
        $host.ui.RawUI.BackgroundColor = $backgroundColor
        Clear-Host }
    'Light Mode Blue' {
        # Define new colors
        $foregroundColor = [System.ConsoleColor]::Blue
        $backgroundColor = [System.ConsoleColor]::White

        # Set console colors
        $host.ui.RawUI.ForegroundColor = $foregroundColor
        $host.ui.RawUI.BackgroundColor = $backgroundColor
        Clear-Host
    }
    'Kahoot Wrong Anwser' {
        # Define new colors
        $foregroundColor = [System.ConsoleColor]::White
        $backgroundColor = [System.ConsoleColor]::DarkRed

        # Set console colors
        $host.ui.RawUI.ForegroundColor = $foregroundColor
        $host.ui.RawUI.BackgroundColor = $backgroundColor
        Clear-Host
    }
    'Kahoot Right Anwser' {
        # Define new colors
        $foregroundColor = [System.ConsoleColor]::White
        $backgroundColor = [System.ConsoleColor]::DarkGreen

        # Set console colors
        $host.ui.RawUI.ForegroundColor = $foregroundColor
        $host.ui.RawUI.BackgroundColor = $backgroundColor
        Clear-Host
    }
}

# Display a message with the new colors
Write-Host "This is a message with custom colors."

# Example using the call operator & with $PSScriptRoot
$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "discord.ps1"
& $scriptPath
