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
    <#
    .SYNOPSIS
        Clear the terminal and run fastfetch to flex~
    #>
  clear
  fastfetch
}

function ompSimple {
    <#
    .SYNOPSIS
        Switch between omp configs (NotSimple -> Simple, and vice-versa)
    #> 
    param(
        [Alias("n")]
        [switch]$no
    )

    clear
    echo ""

    try {
        if ($no) {
            oh-my-posh init pwsh --config $style_path | Invoke-Expression
        } else {
            oh-my-posh init pwsh --config $style_path_simple | Invoke-Expression
        }
    }
    catch {
        Write-host -ForegroundColor Magenta "Encountered Error: $($_.Exception.Message)"
    }   

}

function touch {
    <#
    .SYNOPSIS
        Creates a new file with the specified name and extension
    #>
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
    <#
    .SYNOPSIS
        Open URL using Brave

    .EXAMPLE 
        open google.com

        Open up google.com on Brave Browser
    #> 
    Param ( [string[]]$url )
    start-process brave $url
}

function search {
    <#
    .SYNOPSIS
        Brave search with free‑form queries

    .NOTES
        Remember to change to whatever search engine you're enjoy using (or keep it brave if you want it too)
        
    .DESCRIPTION
        Open up a new Brave browser instance if not yet opened, or opened a new tab if a brave browser has already opened.
        You can typed the search queries without wrapping them using quotes or whatsoever, since it collects all the arguments
        passed as a whoel string.

    .EXAMPLE 
        search why am i so handsome?

        Open up Brave search for "why am i so handsome?"
    #> 
    Param (
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$query
    )

    $fullQuery = $query -join ' '
    $url = "https://search.brave.com/search?q=$([uri]::EscapeDataString($fullQuery))"
    start brave $url
}

function wtf {
    <#
    .SYNOPSIS
        Search prefixed with “wtf …”

    .NOTES
        Remember to change to whatever search engine you're enjoy using (or keep it brave if you want it too)
        
    .DESCRIPTION
        Open up a new Brave browser instance if not yet opened, or opened a new tab if a brave browser has already opened.
        You can typed the search queries without wrapping them using quotes or whatsoever, since it collects all the arguments
        passed as a whoel string.

    .EXAMPLE 
        wtf is printf in C

        Open up Brave search for "wtf is printf in c"
    #> 
    Param (
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$query
    )
    
    $fullQuery = 'wtf ' + $query -join ' '
    $url = "https://search.brave.com/search?q=$([uri]::EscapeDataString($fullquery))"
    start brave $url
}

function howtf {
    <#
    .SYNOPSIS
        Search prefixed with “how tf …”

    .NOTES
        Remember to change to whatever search engine you're enjoy using (or keep it brave if you want it too)
        
    .DESCRIPTION
        Open up a new Brave browser instance if not yet opened, or opened a new tab if a brave browser has already opened.
        You can typed the search queries without wrapping them using quotes or whatsoever, since it collects all the arguments
        passed as a whoel string.

    .EXAMPLE 
        howtf do i accept multiple arguments in pwsh

        Open up Brave search for "how tf do i accept multiple arguments in pwsh"
    #> 
    Param (
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$query
    )

    $fullQuery = 'how tf ' + $query -join ' '
    $url = "https://search.brave.com/search?q=$([uri]::EscapeDataString($fullquery))"
    start brave $url
}

function why {
    <#
    .SYNOPSIS
        Search prefixed with “why …”

    .NOTES
        Remember to change to whatever search engine you're enjoy using (or keep it brave if you want it too)
        
    .DESCRIPTION
        Open up a new Brave browser instance if not yet opened, or opened a new tab if a brave browser has already opened.
        You can typed the search queries without wrapping them using quotes or whatsoever, since it collects all the arguments
        passed as a whoel string.

    .EXAMPLE 
        why do i need to free memory after using malloc C

        Open up Brave search for "why do i need to free memory after using malloc in C"
    #> 
    Param (
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$query
    )

    $fullQuery = 'why ' + $query -join ' '
    $url = "https://search.brave.com/search?q=$([uri]::EscapeDataString($fullquery))"
    start brave $url
}


function translate {
    <#
    .SYNOPSIS
        Open Google Translate (EN -> ID), supports `-r` for reverse mode (ID -> EN)

    .DESCRIPTION
        Open up a new Brave browser instance if not yet opened, or opened a new tab if a brave browser has already opened.
        You can typed the search queries without wrapping them using quotes or whatsoever, since it collects all the arguments
        passed as a whoel string.

    .EXAMPLE 
        translate chicken

        Open up Brave then search translation from EN to ID (chicken -> ayam)

    .EXAMPLE 
        translate -r ayam

        Open up Brave then search translation from ID to EN (ayam -> chicken)
    #> 
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

function compress {
    param(
        [Parameter(Mandatory = $true)][string]$input_path,
        [Parameter(Mandatory = $true)][string]$output_path
    )

    $pyScript = "D:\code\py\compress_file.py"

    python $pyscript $input_path $output_path
}

function mkdird {
    <#
    .SYNOPSIS
        Create a directory and immediately `cd` into it
    #>
    param( [string]$arg )

    mkdir $arg && cd $arg
}

function remove-vscLogo {
    <#
    .SYNOPSIS
        Remove the logo from Visual Studio Code titlebar.
    #> 
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
    <#
    .SYNOPSIS
        Terminates user-session processes.
    .DESCRIPTION
        Retrieves all processes running in the current user session and groups them by process name.

        For each process group, the function will prompt for confirmation before termination:
        - [Y]   Kill the current process group
        - [N]   Skip the current process group
        - [A]   Kill all remaining process groups without further prompts

        When the `-a` / `-killAll` switch is provided, all eligible processes are terminated immediately
        without confirmation.

    .PARAMETER EXCLUDE
        A list of process names that should never be terminated.
        This includes essential Windows processes and commonly running background utilities.

    .PARAMETER killAll
        Skips all confirmation prompts and immediately terminates every eligible process
        in the current user session.

        Alias: -a

    .EXAMPLE
        killall

        Prompts for confirmation before terminating each group of processes.

    .EXAMPLE
        killall -a

        Immediately terminates all eligible processes without prompting.
    #>
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
    <#
    .SYNOPSIS
        Switch Visual Studio Code config (focus -> normal, and vice-versa)
    #> 
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
    <#
        .SYNOPSIS
            Calculate the total size of a directory with a formatting.

        .DESCRIPTION
            Recursivevely walks through the directory and sums up all the sizes.
            The final sum will get formatted into human-readable format (MiB, GiB, etc).

            By default, system files or hiddden are ignored unless you forced them :evil_face: using `-f`.
    #>
    param(
        [string]$path = ".",

        [Alias("f")]
        [switch]$force
    )

    $params = @{
        path=$path
        recurse=$true
    }

    if ($force) { $params.force = $true }

    try {
        switch((ls @params | measure -sum Length).Sum) {
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

function get-func {
    <#
        .SYNOPSIS
            Echo the definition of function that passed as an argument.

        .DESCRIPTION
            If you inputted your own command (such as vscFocus), then it'll output the code of that function.
            If you inputted external command (such as get-childItem), then it'll output the whole definition.
    #>
    Param( [string]$func )

    try {
        Get-Command $func -erroraction stop | Select-Object -ExpandProperty Definition
    }
    catch [System.Management.Automation.CommandNotFoundException] {
        Write-host -ForegroundColor Yellow "Invalid Func Name, bunny... $($_.Exception.Message)"
    }
    catch {
        Write-host -ForegroundColor Magenta "Another Error's Encountered!!🐰: $($_.Exception.Message)"
    }
}

function pwsh-big {
    <#
        .SYNOPSIS
            Open up a 140x50 windows terminal in the center of the screen.
    #>
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
    <#
        .SYNOPSIS
            Copying clangd configs (or any other configs, if you want) into current working directory.

        .DESCRIPTION
            Search through the config path for the $mode, if it's there, then copy it into the cwd, 
            if there isn't any config that equal $mode, then give the list of available configs. 
    #>
    Param(
        [Alias("make")]
        [string]$mode="minimal"
    )

    $file = "D:\custom\clangd-configs\$mode"

    try {
        if (test-path $file) {
            get-content $file | set-content "./.clangd"
            write-host -foregroundColor Magenta 
                ".clangd with the config of $($PSStyle.foreground.Blue)$mode $($PSSTyle.foreground.Magenta)has been successfully created~🎉"
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
    <#
        .SYNOPSIS
            Create a symlink with a specified path and target.

        .PARAMETER path
            Specified that path or the filename of the symlink to be located.

        .PARAMETER target
            Specified the target of which will be used as the source of symlink.

        .EXAMPLE
            symlink ./Microsoft.PowerShell_profile.ps1 $profile

            create a new symlink called Microsoft.PowerShell_profile.ps1 wit hthe source of ~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1

        .NOTES
            honestly speaking, i almost never used symlinks at all, i only used it once or two,
            and idk why but i thought i'll be using it quite often so i build this function.. but in fact,
            after several weeks, i still haven't used it again.. so let me know if there's something
            that's nice to be added.
    #>
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
    <#
        .SYNOPSIS
            A tools to create a horizontal lines in your terminal (same like <hr /> in html)
        
        .DESCRIPTION
            A toosl to make a horizontal lines that can have a pattern that you can customized easily.

            You can add normal ruler, like
            > hr -
            ------------- #till the end of your terminal window.

            Or even combining other symbols!?
            > hr = - =
            ==============
            --------------
            ==============

            > hr =* #
            =*=*=*=*=*=*=*
            ##############

        .EXAMPLE 
            hr
            
            ##############   # till your terminal window's end.
        
        .EXAMPLE
            hr -

            ------------- # till your terminal window's end.

        .EXAMPLE
            hr * - *

            *************
            -------------
            *************
        
        .EXAMPLE
            hr #-#

            #-##-##-##-##-#
    #>
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
    <#
        .SYNOPSIS
            `cd` into a directory and automatically run `ls`
    #>
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
    <#
        .SYNOPSIS
            Get the path of the argument's executable path.

        .EXAMPLE
            whereis nvim

            ~/Program Files/Neovim/bin/nvim.exe
    #>
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
    <#
    .SYNOPSIS
        Toggle komorebi & yasb to be on/off.
    #> 
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
