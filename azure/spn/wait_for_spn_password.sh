#This script is just to test it out on a shell command line before executing it by terraform local-exec.
NEXT_WAIT_TIME=0
until az ad sp credential list --id $(spn) > /dev/null 2>&1 || [[ $NEXT_WAIT_TIME -eq 36 ]]; do
  echo "Waiting for service principal password creation: NEXT_WAIT_TIME"
  sleep $(( NEXT_WAIT_TIME++ ))
done