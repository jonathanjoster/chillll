# activate rails server
cd ~/code/chillll
rails s & \

# open localhost:3000
while ! nc -z localhost 3000; do
  sleep 1
done
open -a /Applications/Google\ Chrome.app http://localhost:3000

# clean up the processes
while nc -z localhost 3000; do
  sleep 10
done
kill $(lsof -ti :3000)
