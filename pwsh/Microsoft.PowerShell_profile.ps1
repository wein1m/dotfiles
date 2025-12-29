# --------──♡ Mai’s PowerShell ~ Private ♡─────────--------------------------------------------------
# Wein’s Profile.ps1
# mainly contain stuffs that makes my terminal workflow enjoyable 🐰
# ───────────────────────────────────────────--------------------------------------------------------


# ❥ Aliases
# ───────────────--------------------------------------------------------───────────────────────────🐰
Set-Alias vim nvim
Set-Alias rename rename-item
Set-Alias grep select-string
Set-Alias nano micro
set-alias rar "c:\Program Files\WinRAR\WinRAR.exe"
Set-Alias gpp g++
Set-Alias wth wtf
Set-Alias omp oh-my-posh

function clearo { . $PROFILE } # Reload Profile
function rmdirs { remove-item -r -fo $args } 
function shutdowns { shutdown -s -t 0 } # Shutdown immediately
function restart { shutdown -r -t 0 } # Restart immediately
function gpath { pwd | scb } # Get Current Working Directory, then copy into clipboard
function spotify { spicetify update } # Update Spicetify


# ❥ My collection of lovely functions
# ───────────────--------------------------------------------------------───────────────────────────🐰
function clearl {
  clear
  fastfetch
}

function touch {
    Param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$files
    )

    if ($files -le 0) {
    write-host -foregroundColor Magenta 
        "What? you want me to create a ghost file?.. give atleast one filename.. bad bunny."
    break
    }

    foreach($file in $files) {
        "" > $file
    }
}

function open {
    Param ( [string[]]$url )
    start brave $url
}

function search {
    Param (
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$query
    )

    $fullQuery = $query -join ' '
    $url = "https://search.brave.com/search?q=$([uri]::EscapeDataString($fullQuery))"
    start brave $url
}

function wtf {
    Param (
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$query
    )
    
    $fullQuery = 'wtf ' + $query -join ' '
    $url = "https://search.brave.com/search?q=$([uri]::EscapeDataString($fullquery))"
    start brave $url
}

function howtf {
    Param (
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$query
    )

    $fullQuery = 'how tf ' + $query -join ' '
    $url = "https://search.brave.com/search?q=$([uri]::EscapeDataString($fullquery))"
    start brave $url
}

function why {
    Param (
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$query
    )

    $fullQuery = 'why ' + $query -join ' '
    $url = "https://search.brave.com/search?q=$([uri]::EscapeDataString($fullquery))"
    start brave $url
}


function translate {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, ValueFromRemainingArguments = $true)]
        [string[]]$query,

        [Alias("r")]
        [switch]$reverse
    )

    $fullQuery = $query -join ' '

    if ($reverse) { 
        $url = "https://translate.google.com/?sl=id&tl=en&text=$([uri]::EscapeDataString($fullQuery))&op=translate" 
    }
    else { 
        $url = "https://translate.google.com/?sl=en&tl=id&text=$([uri]::EscapeDataString($fullQuery))&op=translate" 
    }

    start brave $url
}

function download {
    param(
        [Parameter(Mandatory = $true)][string]$Url,
        [Parameter(Mandatory = $true)][string]$Name,
        [string]$Path = "D:/awairo/"
    )

    $pyScript = "D:\custom\TiktokDownload\main_downloader.py"

    python $pyScript $Url $Name $Path
}

function mkdird {
    param( [string]$arg )

    mkdir $arg && cd $arg
}

function compress {
    param(
        [Parameter(Mandatory = $true)][string]$input_path,
        [Parameter(Mandatory = $true)][string]$output_path
    )

    $pyScript = "D:\code\py\compress_file.py"

    python $pyscript $input_path $output_path
}



function remove-vscLogo {
    param(
        [alias("n")]
        [switch]$notFocus
    )

    $output_loc = "C:\Users\toya\AppData\Local\Programs\Microsoft VS Code\resources\app\out\vs\workbench\workbench.desktop.main.css"

    if ($notFocus) {
        $input_loc = "D:\custom\vsc-settings\settings\vscMode-nonFocus.css"
    } else {
        $input_loc = "D:\custom\vsc-settings\settings\vsc-customcss.css"
    }

    try {
        Get-Content $input_loc | Set-Content $output_loc
        Write-Host "All done~👌 Reload your vsc to see the effect🐰"
    }
    catch {
        Write-Host -ForegroundColor Magenta "Encountered Error: $($_.Exception.Message)"
    }
}


function killall {
    param(
        # most of these are proccesses that shouldn't be terminated
        [string[]]$EXCLUDE = @(
            'explorer', 'System', 'wininit', 'csrss', 'smss', 'services', 
            'lsass', 'winlogon', 'Idle', 'atieclxx', 'backgroundTaskHost', 
            'ctfmon', 'dllhost', 'altsnap', "flow.launcher", "windhawk"
        ),

        [alias("a")]
        [switch]$killAll
    )

    $processes = get-process | where-object {
        $_.SessionId -eq (get-process -Id $PID).SessionId -and
        $_.ProcessName -notin $EXCLUDE
    }

    $groups = $processes | group-object ProcessName

    foreach ($group in $groups) {
        if (-not $killAll) {
            $pids = ($group.Group | foreach-object { $_.Id }) -join ', '
            $choice = read-host "Kill all '$($group.Name)' (PIDs: $pids)? [Y/N/A for All]"
        }
        if ($choice -match '^[Yy]$' -or $killAll) {
            foreach ($proc in $group.Group) {
                try {
                    stop-process -Id $proc.Id -Force -ErrorAction Stop
                    write-host "🐰 $($proc.ProcessName) with the PID of $($proc.Id) has been successfully killed🫡" -ForegroundColor Green
                } catch {
                    write-host "😥 Failed to kill $($proc.ProcessName) (PID $($proc.Id)) T-T" -ForegroundColor Red
                }
            }
        }
        elseif ($choice -match '^[Aa]$') {
            $killAll = $true
            foreach ($proc in $group.Group) {
                try {
                    stop-process -Id $proc.Id -Force -ErrorAction Stop
                    write-host "🐰 $($proc.ProcessName) with the PID of $($proc.Id) has been successfully killed🫡" -ForegroundColor Green
                } catch {
                    write-host "😥 Failed to kill $($proc.ProcessName) (PID $($proc.Id)) T-T" -ForegroundColor Red
                }
            }
        }
    }
    write-host "`nAll done cleaning up, honey~" -ForegroundColor Cyan
}

function vscFocus {
    param(
        [Alias("n")]
        [switch]$notFocus
    )

    $defaultPath = "C:\Users\toya\AppData\Roaming\Code\User\settings.json"
    $customPath = "D:\custom\vsc-settings\settings\"

    foreach ($arg in $args) {
        # the regex to accept only 1 word (ofc cuz it's flag lmao)
        if ($arg -match '^-[a-zA-Z]+$' -and $arg -ne '-n') {
            Write-host  -ForegroundColor Cyan 
                "❌ What's that, $($arg)? That's not a valid flag, silly. Only use -n, got it?"
            return
        }
    }

    try {
        if ($notFocus) {
            Get-Content "$($customPath)\normal.jsonc" | Set-Content $defaultPath
        } else {
            Get-Content "$($customPath)\focus.jsonc" | Set-Content $defaultPath
        }
            remove-vscLogo -notFocus:$notFocus
        }
        catch {
            Write-host -ForegroundColor Magenta "Encountered Error: $($_.Exception.Message)"
    }
}

function get-size {
    param(
        [string]$arg = ".",

        [Alias("f")]
        [switch]$force
    )

    $params = @{
        path=$arg
        recurse=$true
    }

    if ($force) { $params.force = $true }

    try {
        switch((ls @params |measure -sum Length).Sum) {
        {$_ -gt 1GB} {
            '{0:0.0} GiB' -f ($_/1GB)
            break
        }
        {$_ -gt 1MB} {
            '{0:0.0} MiB' -f ($_/1MB)
            break
        }
        {$_ -gt 1KB} {
            '{0:0.0} KiB' -f ($_/1KB)
            break
        }
            default { "$_ bytes" }
        }
    }
    catch {
        Write-host -ForegroundColor Magenta "Error's Encountered!!🐰: $($_.Exception.Message)"
    }
}

function ompSimple {
  clear
  echo ""
  oh-my-posh init pwsh --config $style_path_simple | Invoke-Expression
}

function get-func {
    Param( [string]$func )

    try {
        get-content -erroraction stop function:$func
    }
    catch [System.Management.Automation.ItemNotFoundException] {
        Write-host -ForegroundColor Yellow "Invalid Func Name, bunny... $($_.Exception.Message)"
    }
    catch {
        Write-host -ForegroundColor Magenta "Another Error's Encountered!!🐰: $($_.Exception.Message)"
    }
}

function pwsh-big {
    $cols = 140
    $rows = 50

    $width  = $cols * 9
    $height = $rows * 17

    $screenWidth  = 1920
    $screenHeight = 1080

    # Screen's center
    $x = [math]::Round(($screenWidth  - $width)  / 2)
    $y = [math]::Round(($screenHeight - $height) / 2)

    # i need to specify the wt manually cuz powershell just kinda weird and ignore the arguments ;-; 
    # (it only happens on function, if you try run `wt ${arguments}` directly, it'll run perfectly fine
    $wt = "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe"
    Start-Process $wt -ArgumentList "--pos", "$x,$y", "--size", "$cols,$rows"
}

function clangd {
    Param(
        [Alias("make")]
        [string]$mode="minimal"
    )

    $file = "D:\custom\clangd-configs\$mode"

    try {
        if (test-path $file) {
            get-content $file | set-content "./.clangd"
            write-host -foregroundColor Magenta ".clangd with the config of $($PSStyle.foreground.Blue)$mode $($PSSTyle.foreground.Magenta)has been successfully created~🎉"
        } else {
            $configs = (ls -file 'D:\custom\clangd-configs').name

            write-host -ForegroundColor Magenta "Invalid Config, Bunny🐰. Here's list of available configs:"
            foreach($config in $configs) {
                write-host -foregroundColor Blue "- $($configs[$i])"
            }
        }
    }
    catch {
        Write-host -ForegroundColor Magenta "Error Occurreedddd!!!!!!!!!!🐇🐇: $($_.Exception.Message)"
    }
}

function symlink {
    Param(
        [string]$path=".",
        [string]$target=$(throw "forgot to add the target path, huh..")
    )

    try{
        new-item -itemType SymbolicLink -path $path -target $target -errorAction Stop
    }
    catch {
        write-host -foregroundColor Magenta "Maydayyy!!!🐰🐰 $($_.Exception.Message)"
    }
}

function Get-FileMetaData { 
    <# 
    .SYNOPSIS 
        Get-FileMetaData returns metadata information about a single file. 
 
    .DESCRIPTION 
        This function will return all metadata information about a specific file. It can be used to access the information stored in the filesystem. 
    
    .EXAMPLE 
        Get-FileMetaData -File "c:\temp\image.jpg" 

        Get information about an image file. 

    .EXAMPLE 
        Get-FileMetaData -File "c:\temp\image.jpg" | Select Dimensions 

        Show the dimensions of the image. 

    .EXAMPLE 
        Get-ChildItem -Path .\ -Filter *.exe | foreach {Get-FileMetaData -File $_.Name | Select Name,"File version"} 

        Show the file version of all binary files in the current folder. 
    #> 

    param(
        [Parameter(Mandatory=$True)]
        [string]$File
    ) 

    if(!(Test-Path -Path $File)) { 
    write-host -foregroundColor Magenta "Invalid filename, bunny~"
    break
    } 

    $tmp = Get-ChildItem $File 
    $pathname = $tmp.DirectoryName 
    $filename = $tmp.Name 

    $hash = @{}
    try{
        $shellobj = New-Object -ComObject Shell.Application 
        $folderobj = $shellobj.namespace($pathname) 
        $fileobj = $folderobj.parsename($filename) 

        for($i=0; $i -le 294; $i++) { 
            $name = $folderobj.getDetailsOf($null, $i);
            if($name){
                $value = $folderobj.getDetailsOf($fileobj, $i);
                if($value){
                    $hash[$($name)] = $($value)
                }
            }
        }
    }
    catch {
        write-host -foregroundColor Magenta "Errorrrrrrrrrrr~ $($_.Exception.Message)"
    }
    finally{
        if($shellobj){
            [System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$shellobj) | out-null
        }
    }
    return New-Object PSObject -Property $hash
}

function hr {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$chars = @("#")
    )

    $cols = $Host.UI.RawUI.WindowSize.Width;

    if ($cols -le 0) {
        $cols = 80;
    }

    forEach($c in $chars) {
        echo ($c * $cols).substring(0,$cols);
    }
}

function cdd { 
    Param( [string] $arg )

    if (!$arg) {
        write-host -foregroundColor Magenta "... atleast tell me where you're going, bun.";
        break;
    }

    try {
        cd $arg && ls;
    }
    catch {
        write-host -foregroundColor Magenta "ERRORRR OCCURREDDD~~ $($_.Exception.Message)";
    }
}

# hueh T_T the 'where' is already taken as an alias for Where-Obect, and idk how to delete an alias permanently,
# soo.. just bear with 'whereis'🐰
function whereis() { 
    param( [string]$arg )

    if (!$arg) {
        write-host -foregroundColor Magenta "huh? where's what?";
        break;
    }

    try {
        write-host (get-command $arg -errorAction stop).source;
    }
    catch [System.Management.Automation.CommandNotFoundException] {
        write-host -foregroundColor Magenta "Cannot find '$($arg)'.";
        write-host -foregroundColor Magenta "...It's not hiding. it just doesn't exist."
    }
    catch {
        write-host -foregroundColor Magenta "ERRORRR OCCURREDDD~~ $($_.Exception.Message)";
    } 
}

# tbh i dont know what to name this cuz komorebi seems too long, so~
function komom {
    Param(
        [Alias('n')]
        [switch]$stop
    )

    foreach ($arg in $args) {
        # the regex to accept only 1 word (ofc cuz it's flag lmao)
        if ($arg -match '^-[a-zA-Z]+$' -and $arg -ne '-n' -or '-stop') {
            Write-host  -ForegroundColor Cyan
                "❌ What's that, $($arg)? That's not a valid flag, silly. Only use -stop or -n, got it?"
            return
        }
    }

    try {
        if(!$stop) {
            komorebic start --whkd 
            yasbc start
            clearl
        }
        else {
            $check = read-host "Are you really really sure to stop komorebi & yasb (y/n)?".ToLower()
            switch ($check) {
                y {
                    komorebic stop --whkd
                    yasbc stop
                    clearl
                }
                n {
                    write-host  -ForegroundColor Cyan 
                        "hehe~ i know you're still in love with them~"
                }
                Default {
                    Write-host  -ForegroundColor Cyan
                        "❌ What's that, $($_)? That's not a valid flag, silly. Only use y or n, got it?"
                }
            }
        }
    }
    catch {
        Write-Host -ForegroundColor Magenta "HAHA!! $($_.Exception.Message)"
    }
}


# ❥ Shell & Prompt Configurations
# ───────────────--------------------------------------------------------───────────────────────────🐰

# Enable inline predictions (fish-style)
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView


# oh-my-posh thingy
$style_path = 'C:\Users\toya\AppData\Local\Programs\oh-my-posh\themes\mai.omp.json'
$style_path_simple = 'C:\Users\toya\AppData\Local\Programs\oh-my-posh\themes\simple.omp.json'

oh-my-posh init pwsh --config $style_path | Invoke-Expression

clear
fastfetch


# ❥ Notes (for me)
# ───────────────--------------------------------------------------------───────────────────────────🐰

######## NOTE ########
# to get what exception does the error thrown, use
# write-host -foregroundColor cyan $_.Exception.GetType();
#
# pwsh command history
# $($env:APPDATA)\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
######################
echo "TODO: build fastfetch clone using rust; play with pwsh get-process from manpage"
