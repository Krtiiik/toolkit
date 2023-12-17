param (
    [string]$venvName
)

# Check if the virtual environment name is provided
if ([string]::IsNullOrEmpty($venvName)) {
    Write-Host "Usage: .\create_venv.ps1 -venvName <venv_name>"
    exit 1
}

# Specify the directory where virtual environments will be created
$venvDir = ""

# Check if the virtual environment already exists
if (Test-Path "$venvDir\$venvName") {
    Write-Host "Virtual environment '$venvName' already exists in $venvDir"
    exit 1
}

# Create the virtual environment
$venvPath = Join-Path -Path $venvDir -ChildPath $venvName
py -m venv $venvPath

# Check if the virtual environment was created successfully
if (Test-Path "$venvPath\Scripts\activate") {
    Write-Host "Virtual environment '$venvName' created successfully in $venvDir"
} else {
    Write-Host "Failed to create virtual environment '$venvName'"
}