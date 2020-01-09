param ($origin = ".\default", $destination = ".\destination", $data_file = "data.csv")

$data = Import-Csv -Path .\$data_file
$data | Get-Member
$data | Format-Table

$data | ForEach-Object {
    foreach ($property in $_.PSObject.Properties) {
        Write-Host $property.Name, $property.Value
    }
}

# Write-Host "origin: $origin, destination: $destination, data: $data_file"


# $path = "d:\scratch\export.csv"
# $csv = Import-Csv -path $path

# foreach($line in $csv)
# {
#     $properties = $line | Get-Member -MemberType Properties
#     for($i=0; $i -lt $properties.Count;$i++)
#     {
#         $column = $properties[$i]
#         $columnvalue = $line | Select -ExpandProperty $column.Name

#         # doSomething $column.Name $columnvalue
#         # doSomething $i $columnvalue
#     }
# }
