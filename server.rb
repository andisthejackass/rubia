system ('cd /home/hero/Desktop/backup && git init --bare')
print "If your client completed Step 2 press any key to continue ...\n"
gets
system ('git clone backup backup-clone')
while 1==1 do
  sleep(1)
  system('cd backup-clone && git remote update')
  diff = `cd backup-clone && git diff origin/master`
  if diff.length > 5
    print "\n\nYour files have been modified!\nDo you want to see those changes? Y/N ?\n"
    answer = gets
    if answer == "y\n"
      diff.each_line do |line|
        if (line.start_with?("+")) || (line.start_with?("-"))
          if (line[0..2] == '+++') || (line[0..2] == '---')
            print "file modifided: " + line[6..-1] + "\n"
          else
            print "lines modified: " + line[1..-1] + "\n"
          end
        end
      end
    else 
      print "Fine! Have it your way!\n"
    end
    print "Do you want to accept the changes? Y/N ?\n"
    answer2 = gets
    if answer2 == "y\n"
      system ('cd backup-clone && git pull origin master')
      print "Changes Accepted\n"
    else 
      system("ssh root@192.168.1.69 -p 22 \'cd /User/Documents/SecurityDemo ; git reset --hard HEAD~1 ; echo \"reset @ #{Time.now}\" >> log.txt ; git add . && git commit -am \'rollback\' && git push backup master\'")
      system ('cd backup-clone && git pull')
      print "No changes will be made\n"
    end
  end
end  
