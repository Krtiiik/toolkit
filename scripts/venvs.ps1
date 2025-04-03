$venvDir = "PUT VENV DIRECTORY HERE"

function venv-create {
    param (
        [string]$venvName,
        [Switch]$help
    )

    # Check if the virtual environment name is provided
    if ($help -or [string]::IsNullOrEmpty($venvName)) {
        Write-Host "Usage: Create-VirtualEnvironment -venvName <venv_name>"
        return
    }

    # Check if the virtual environment already exists
    if (Test-Path "$venvDir\$venvName") {
        Write-Host "Virtual environment '$venvName' already exists in $venvDir"
        return
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
}

function venv-activate {
    param (
        [ValidateSet([SupportedVenvsValidator])]
        [string]$venvName,
        [Switch]$help
    )

    # Display the script usage text
    function Usage {
        Write-Host "Usage: Activate-VirtualEnvironment -venvName <venv_name>"
        Write-SupportedVenvs
    }

    # Check if the help flag is provided
    if ($help) {
        Usage
        return
    }

    # Check if the virtual environment name is provided
    if ([string]::IsNullOrEmpty($venvName)) {
        Write-Host "Usage: Activate-VirtualEnvironment -venvName <venv_name>"
        Write-SupportedVenvs
        return
    }

    # Check if the virtual environment exists
    if (-not (Test-Path "$venvDir\$venvName")) {
        Write-Host "Virtual environment '$venvName' not found in $venvDir"
        Write-SupportedVenvs
        return
    }

    # Activate the virtual environment
    & "$venvDir\$venvName\Scripts\Activate.ps1"

    # Provide a message to indicate that the virtual environment is activated
    Write-Host "Activated virtual environment: $venvName"
}

function venv-delete {
    param (
        [ValidateSet([SupportedVenvsValidator])]
        [string]$venvName,
        [Switch]$help
    )

    # Check if the virtual environment name is provided
    if ($help -or [string]::IsNullOrEmpty($venvName)) {
        Write-Host "Usage: Remove-VirtualEnvironment -venvName <venv_name>"
        return
    }

    # Check if the virtual environment exists
    if (-not (Test-Path "$venvDir\$venvName")) {
        Write-Host "Virtual environment '$venvName' not found in $venvDir"
        return
    }

    # Remove the virtual environment
    Remove-Item -Path "$venvDir\$venvName" -Recurse -Force

    # Provide a message to indicate that the virtual environment is deleted
    Write-Host "Deleted virtual environment: $venvName"
}

function SupportedVenvs { # Get the list of virtual environments
    Get-ChildItem -Path $venvDir -Directory | Select-Object -ExpandProperty Name
}

function Write-SupportedVenvs { # Display available virtual environments
    Write-Host "Available virtual environments:"
    SupportedVenvs
}

Class SupportedVenvsValidator
: System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $venvNames = SupportedVenvs
        return [string[]] $venvNames
    }
}
