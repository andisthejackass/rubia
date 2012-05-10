user = ARGV[0]
ip = ARGV[1]
port = ARGV[2]
system 'echo "client.rb" >> .gitignore'
system 'git init && git add . && git commit -am \'first commit\''
ssh = 'ssh ' + user + '@' + ip + ' -p ' + port
gradd = 'git remote add backup ssh://' + user + '@' + ip + ':' + port + '/home/hero/Desktop/backup'
system "#{gradd}"
mkdir = ssh + ' mkdir /home/hero/Desktop/backup'
system ("#{mkdir}")
print "Run server and press any key to continue ...\n"
STDIN.gets
system ('git push backup master')
print "\n\nYou may now continue to Step 2 at your server\n*********************************************\n--[ Client Running ]--\n"
while 1==1 do
  sleep(10)
  gadtime = 'git add . && git commit -am \'' + Time.now.to_s + '\''
  #echo gadtime
  system ("#{gadtime}")
  system ('git push backup master')
end

#system("#{ssh}")
