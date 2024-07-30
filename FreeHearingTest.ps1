# Function to test hearing for a specified ear
function TestHearing {
    param (
        [string]$ear
    )

    # Define the hearing assessment thresholds in kHz
    $goodHearingThreshold = 20
    $averageHearingThreshold = 16
    $hearingProblemsThreshold = 12

    # Variable to store the highest frequency heard
    $highestFrequencyHeard = 0

    for ($i = 1; $i -lt 33; $i += 1) {
        $frequency = $i * 1000 # Convert kHz to Hz
        Read-Host "> Press Enter to beep at $i kHz ($frequency Hz) in your $ear ear"
        [console]::beep($frequency, 1000)
        $response = Read-Host "Could you hear the $i kHz beep in your $ear ear? (Y/N)"
        
        if ($response -eq "Y" -or $response -eq "y") {
            $highestFrequencyHeard = $i
            clear
        } else {
            clear
            break
        }
    }

    # Provide feedback based on the highest frequency heard
    if ($highestFrequencyHeard -ge $goodHearingThreshold) {
        return "You have good hearing in your $ear ear. You heard up to $highestFrequencyHeard kHz."
    } elseif ($highestFrequencyHeard -ge $averageHearingThreshold) {
        return "You have average hearing in your $ear ear. You heard up to $highestFrequencyHeard kHz."
    } elseif ($highestFrequencyHeard -ge $hearingProblemsThreshold) {
        return "You might be starting to have hearing problems in your $ear ear. You heard up to $highestFrequencyHeard kHz."
    } else {
        return "You have significant hearing loss in your $ear ear. You heard up to $highestFrequencyHeard kHz."
    }
}

# Instructions for the test
clear
Write-Host "Welcome to the Hearing Test."
Write-Host "You will be testing your hearing for both your left and right ears."
Write-Host "The test will play a series of beeps at different frequencies."
Write-Host "For each beep, indicate if you can hear it by typing 'Y' or 'N'."
Write-Host "Press Enter to begin the test."

# Start the test
Read-Host "> Press Enter to start with your left ear"

# Test for the left ear
$leftEarResult = TestHearing -ear "left"

Write-Host "Let's switch ears."

# Test for the right ear
Read-Host "> Press Enter to start with your right ear"
$rightEarResult = TestHearing -ear "right"

# Print the results at the end
clear
Write-Host "`nResults:"
Write-Host $leftEarResult
Write-Host $rightEarResult