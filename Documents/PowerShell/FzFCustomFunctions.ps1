$cmdletName = "Invoke-Fzf"
if (Get-Command -Name $cmdletName -ErrorAction SilentlyContinue) {
    New-Alias -Name "fkill" -Scope Global -Value Invoke-FuzzyKillProcess -ErrorAction Ignore

    function Invoke-FzfRipgrep {

        # Store the original value
        $originalValue = $env:FZF_DEFAULT_COMMAND

        # Change the value of the environment variable
        $sleepCmd = ''
        $trueCmd = 'cd .'
        $RG_PREFIX = "rg --column --line-number --no-heading --color=always --smart-case "
        $INITIAL_QUERY="."
        $tmp="$RG_PREFIX ""$INITIAL_QUERY"""


        [System.Environment]::SetEnvironmentVariable("FZF_DEFAULT_COMMAND",
$tmp, [System.EnvironmentVariableTarget]::Process)
        $fzf_command = "fzf"
        $fzfArgs = @(
          "--ansi",
          "--color", "hl:-1:underline,hl+:-1:underline:reverse",
          "--disabled",
          "--query", $INITIAL_QUERY,
          "--bind", "change:reload:$sleepCmd $RG_PREFIX {q} || $trueCmd",
          "--bind", "ctrl-f:unbind(change,ctrl-f)+change-prompt( +✅ fzf> )+enable-search+clear-query+rebind(ctrl-r)",
          "--bind", "ctrl-r:unbind(ctrl-r)+change-prompt(🔎 ripgrep> )+disable-search+reload($RG_PREFIX {q} || $trueCmd)+rebind(change,ctrl-f)",
          "--prompt", "🔎 ripgrep> ",
          "--delimiter", ":", 
          "--header", "CTRL-R (ripgrep) / CTRL-F (fzf) / CTRL-V (nvim)",
          "--preview", "bat --color=always {1} --highlight-line {2}",
          "--preview-window", "up,50%,border-bottom,+{2}+3/3,~3",
          "--bind", "ctrl-v:become(nvim {1} +{2})"
        )

          & $fzf_command $fzfArgs
        
        [System.Environment]::SetEnvironmentVariable("FZF_DEFAULT_COMMAND",
$originalValue, [System.EnvironmentVariableTarget]::Process)
    }
    New-Alias -Name "frg" -Scope Global -Value Invoke-FzfRipgrep -ErrorAction Ignore

    function Invoke-FzfBat {

        # Store the original value
        $originalValue = $env:FZF_DEFAULT_COMMAND

        # Change the value of the environment variable
        [System.Environment]::SetEnvironmentVariable("FZF_DEFAULT_COMMAND",
'fd --color=always --type f', [System.EnvironmentVariableTarget]::Process)
        $fzf_command = "fzf"
        $fzfArgs = @(
          "--ansi",
          "--bind", "ctrl-d:change-prompt(󰝰  Directories> )+reload(fd --color=always --type d)+unbind(ctrl-v)+change-preview(lsd --color=always --tree -la --depth 2 {})",
          "--bind", "ctrl-f:change-prompt(  Files> )+reload(fd --color=always --type f)+rebind(ctrl-v)+change-preview(bat --line-range=:50 --color=always {})",
          "--prompt", "  Files> ",
          "--header", "CTRL-D: Directories / CTRL-F: Files / CTRL-V: NVIM",
          "--preview", "bat --line-range=:50 --color=always {}",
          "--preview-window", "up,60%,border-bottom,+{2}+3/3,~3",
          "--bind", "ctrl-v:become(nvim {})"
        )

          & $fzf_command $fzfArgs
        
        [System.Environment]::SetEnvironmentVariable("FZF_DEFAULT_COMMAND",
$originalValue, [System.EnvironmentVariableTarget]::Process)
    }
    New-Alias -Name "fbat" -Scope Global -Value Invoke-FzfBat -ErrorAction Ignore
}
