param (
    [Parameter(Mandatory)]
    [string]$Names,

    [Parameter(Mandatory)]
    [string]$From,

    [Parameter(Mandatory)]
    [string]$To,

    [Parameter(Mandatory)]
    [string]$Extension,

    [string]$Prefix,

    [string]$Suffix
)

If (Test-Path -Path $Names) {
    $names_list = Import-Csv -Path "$Names"
}
else {
    Write-Error "File $Names does not exist." -ErrorAction Stop
}

If (-Not (Test-Path -Path $From)) {
    Write-Error "Original file $From does not exist." -ErrorAction Stop
}

If (-Not (Test-Path -Path $To)) {
    Write-Error "Directory $To does not exist." -ErrorAction Stop
}

function GenerateFiles {
    param ([string]$Pre = "", [string]$Suf = "")

    $Pre = $($Pre -replace "\s+", "")
    $Suf = $($Suf -replace "\s+", "")

    foreach ($name in $names_list) {
    
        Copy-Item -Path $From -Destination $($To + $Pre + $name.Nome + $Suf + $Extension)

    }

    Write-Output "All files are created successfully!"

}

If (-Not [string]::IsNullOrWhiteSpace($Prefix) -And -Not [string]::IsNullOrWhiteSpace($Suffix)) {
    GenerateFiles -Pre $Prefix -Suf $Suffix
}
ElseIf (-Not [string]::IsNullOrWhiteSpace($Prefix) -And [string]::IsNullOrWhiteSpace($Suffix)) {
    GenerateFiles -Pre $Prefix
}
ElseIf ([string]::IsNullOrWhiteSpace($Prefix) -And -Not [string]::IsNullOrWhiteSpace($Suffix)) {
    GenerateFiles -Suf $Suffix
}
Else {
    GenerateFiles
}
