[System.Environment]::SetEnvironmentVariable('EDITOR','nvim')

if (Get-Command wezterm -errorAction SilentlyContinue){
    [System.Environment]::SetEnvironmentVariable('TERMINAL','wezterm')
    [System.Environment]::SetEnvironmentVariable('TERM','wezterm')
}

if (Get-Command bat -errorAction SilentlyContinue)
{
    if (-not (Test-Path "$(bat --config-dir)/themes"))
    {
        mkdir "$(bat --config-dir)/themes"
    }

    # check if file 'Catpuccin Frappe.tmTheme' is present 
    if (-not (Test-Path "$(bat --config-dir)/themes/Catppuccin Frappe.tmTheme"))
    {
        # download the theme file
        Invoke-WebRequest -Uri https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme -OutFile ( New-Item -Path "$(bat --config-dir)/themes/Catppuccin Frappe.tmTheme" -Force )
        bat cache --build
    }
}
[System.Environment]::SetEnvironmentVariable('BAT_THEME','Catppuccin Frappe')
