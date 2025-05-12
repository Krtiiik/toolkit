function Iterate {
	param (
		[int]$count,
		[Parameter(ValueFromRemainingArguments = $true)]
		$command
	)

	if (-not $count -or $count -le 0) {
		Write-Error "You must provide a positive integer for 'count'."
		return
	}

	if ($command.Count -eq 1 -and $command[0] -is [ScriptBlock]) {
		for ($i = 0; $i -lt $count; $i++) {
			& $command[0]
		}
	} elseif ($command -is [System.Collections.IEnumerable] -and ($command | ForEach-Object { $_ -is [string] }) -notcontains $false) {
		for ($i = 0; $i -lt $count; $i++) {
			$expandedCommand = ($command -join " ") -replace '\$i', $i
			Invoke-Expression $expandedCommand
		}
	} else {
		Write-Error "Unsupported command type. Please provide a list of strings or a ScriptBlock."
	}
}
