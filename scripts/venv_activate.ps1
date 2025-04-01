# Define the param block with argument and auto-completion settings
param (
    [ValidateSet([VenvNames])]
    [string]$venvName
)

# Specify the directory where virtual environments are stored
$venvDir = ""

# Display available virtual environments
function Write-SupportedVenues {
    Write-Host "Available virtual environments:"
    Get-ChildItem -Path $venvDir -Directory | Select-Object -ExpandProperty Name
}

# Display the script usage text
function Usage {
    Write-Host "Usage: .\activate_venv.ps1 -venvName <venv_name>"
    Write-SupportedVenues
}

Class VenvNames : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        # Get the list of virtual environments
        $venvDir = ""
        $venvNames = Get-ChildItem -Path $venvDir -Directory | Select-Object -ExpandProperty Name
        return $venvNames
    }
}

# ~~~~~~~ Script ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Check if the help flag is provided
if ($args -contains "--help" -or $args -contains "-?") {
    Usage
    exit 0
}

# Check if the virtual environment name is provided
if ([string]::IsNullOrEmpty($venvName)) {
    Write-Host "Usage: .\activate_venv.ps1 -venvName <venv_name>"
    Write-SupportedVenues
    exit 1
}

# Check if the virtual environment exists
if (-not (Test-Path "$venvDir\$venvName")) {
    Write-Host "Virtual environment '$venvName' not found in $venvDir"
    Write-SupportedVenues
    exit 1
}

# Activate the virtual environment
& "$venvDir\$venvName\Scripts\Activate.ps1"

# Provide a message to indicate that the virtual environment is activated
Write-Host "Activated virtual environment: $venvName"
