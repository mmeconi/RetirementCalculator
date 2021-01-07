<#
    .SYNOPSIS
        Calculator to determine retirement date.
    .DESCRIPTION
        This program requires the user to input their birthdate in a format that matches the regular expression.
        Depending on whether the inidividual's birthday is affected by a leap year or not, their data is processed
        and a retirement date is outputted to the console based on an anticipated retirement age of 67.
    .NOTES
        AuthorName: Marc Meconi
        DateLastModified: November 18, 2020
 #>

Set-StrictMode -version Latest

# Pattern asks for mm/dd/yyyy. {1,2} means minimum 1 character inputted, maximum 2.
$pattern = '^\d{1,2}/\d{1,2}/\d{4}$'


Write-Host "==============================================================" -foregroundcolor Magenta
Write-Host "            SENECA SOFTWARE RETIREMENT CALCULATOR             " -foregroundcolor Magenta
Write-Host "==============================================================" -foregroundcolor Magenta

# Loop continues to ask for user to input birthdate until it matches $pattern regular expression
Do{
$birthdate = Read-Host "Enter date of birth in the format [mm/dd/yyyy]"
}while ($birthdate -notmatch $pattern)

#Splits birthdate data in useable integers
$dateArray = $birthdate.split('/')
[int]$month = $dateArray[0]
[int]$day = $dateArray[1]
[int]$year = $dateArray[2]

#Determines the number of days in a month depending on $month input; used later
if ($month -in 1,01,3,03,5,05,7,07,8,08,10,12){
[int]$DaysInMonth = 31
}
elseif ($month -in 2,02){
[int]$DaysInMonth = 28
}
else
{[int]$DaysInMonth = 30
}

# Determines if user inputted a birthdate that is impacted by a leap year; resolves True or False
$leapyear = [datetime]::IsLeapYear($year + 67)


<# If, in fact, user's retirement date is affected by leap year, the first part of the If statement is used
   If unaffected by leap year, "else" section is used #>
if ($month -in 2,02 -and $leapyear -eq "True"){
$month = 3
$day = 1
$RetirementDate = get-date -month $month -day $day -year $year
write-host "You will retire " -NoNewline
Write-Host $RetirementDate.addyears(67).ToLongDateString() -ForegroundColor magenta
} else {
$RetirementDate = get-date -month $month -day $DaysInMonth -year $year
Write-host "You will retire " -NoNewline
Write-Host $RetirementDate.addyears(67).ToLongDateString() -ForegroundColor magenta
}