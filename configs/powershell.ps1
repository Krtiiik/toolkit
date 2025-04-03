# Prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$ESC = [char]27
$PromptPrefix = "$ESC[?12l$ESC[38;2;255;102;0m" + $env:UserName +	# user
		"$ESC[96m@$ESC[38;2;255;102;0m" + $env:COMPUTERNAME +	# @computer 
		"$ESC[96m: $ESC[32m"					# :
$PromptCommand = "$ESC[96m`r`n$> $ESC[39m"

function ShortPath
{
	param(
		[string]$Path,
		[int]$MaxLength = 80
	)

	if ($Path.Length -le $MaxLength) {
		return $Path
	}

	$terminalWidth = $Host.UI.RawUI.BufferSize.Width

	$splitPath = $Path -split '\\'
	$len = $splitPath[0].Length + $splitPath[-1].Length + 1
	$res = $splitPath[-1]

	for ($i = $splitPath.Length - 2; $i -gt 0; $i--) {
		$cdir = $splitPath[$i]
		if ($len + $cdir.Length + 5 -ge $MaxLength) {
			$res = $splitPath[0] + "\...\" + $res
			break
		}

		$res = $splitPath[$i] + "\" + $res
		$len += $splitPath[$i].Length + 1
	}

	return $res
}

function Prompt
{
	$UncoloredPromptPrefix = ($env:UserName + "@" + $env:COMPUTERNAME + ": ")
	$PromptPrefix + (ShortPath (Get-Location) ($Host.UI.RawUI.BufferSize.Width - $UncoloredPromptPrefix.Length)) + $PromptCommand
}

# Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

New-Alias py Python

# Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function yt-dlp-mp4 { yt-dlp.exe -o "%(title)s.%(ext)s" -f "bv*+ba/b" $args }
function yt-dlp-mp3 { yt-dlp.exe -o "%(title)s.%(ext)s" -f "ba" -x --audio-format "mp3" $args }

function ping-Google { ping -t 8.8.8.8 }

# Include functions for creating and activating Python virtual environments
# . "$PSScriptRoot\venvs.ps1"
