# This script runs docker compose with a port that is not currenly in use
# `InitPort` is tried first and then updated until an unused port is found
# The docker image that starts uses the unused port
# Args:
# ----
# InitPort: Port to start with for check (Default=8888)
param ($InitPort=8888)

function Check-Port-Use($PortNumber) {
# Function to check if port is in use
# Args:
# -----
# PortNumber: Port number to check
#
# Return:
# -----
# Boolean: where the port is in use or `LISTENING`

  $PortDetails = netstat -ano | findstr $PortNumber | findstr LISTENING
  if($PortDetails -eq $NULL) {$PortInUse=$FALSE}else {$PortInUse=$TRUE}
  
  return $PortInUse 
  }

While (Check-Port-Use($InitPort)) {
  $InitPort ++
}

# write temporary .env file for port to use
mkdir -Force ./tmp/ | Out-Null
"Jupyter_Port=$InitPort" >> ./tmp/.env

try{
  # Run docker compose with new .env file
  docker-compose --env-file=./tmp/.env up
}
Finally{
  #Clean Up temporary files
  rm -R ./tmp/
}
