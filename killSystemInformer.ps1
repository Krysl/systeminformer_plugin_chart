# Get the environment variable and normalize the path
$path = ($env:SYSTEMINFORMER_GIT_FOLDER + "/bin/Debug64/SystemInformer.exe") -replace '/', '\'

# Find the process and attempt to terminate it
$process = Get-Process | Where-Object { ($_.Path -replace '/', '\') -eq $path }

if ($process) {
  # If the process is found, attempt to terminate it
  try {
    $process | Stop-Process -Force
    Write-Host "Successfully terminated process: $($process.Name)"
  } catch {
    Write-Host "Failed to terminate process: $($process.Name). Error: $_"
  }
} else {
  Write-Host "No matching process found: $path"
}
