# frozen_string_literal: true

# CONGRATS! you got this file as part of the emory/EULM footer gem package. it's supposed to be here! 
# If you want to make changes to the file, I recommend renaming it so that it doesn't get accidentally rewritten with gem updates.

# the important part is figuring out this path from where the app is running
REVISIONS_LOGFILE = ("/opt/#{ENV['PROJECT_NAME']}/revisions.log")

GIT_SHA =
  if File.exist?(REVISIONS_LOGFILE)
   `tail -1 #{REVISIONS_LOGFILE}`.chomp.split(" ")[3].gsub(/\)$/, "")
  elsif File.exist?(".git")
    `git rev-parse HEAD`.chomp
  else
    'Current release'
  end

BRANCH =
    if 
    File.exist?(REVISIONS_LOGFILE)
    `tail -1 #{REVISIONS_LOGFILE}`.chomp.split(" ")[1]
  elsif 
    File.exist?(".git")
    `git rev-parse --abbrev-ref HEAD`.chomp
  else
    `Current branch`
  end

LAST_DEPLOYED =
  if File.exist?(REVISIONS_LOGFILE)
    deployed = `tail -1 #{REVISIONS_LOGFILE}`.chomp.split(" ")[7]
    Date.parse(deployed).strftime("%d %B %Y")
  elsif File.exist?(".git")
   `git log -1 --format=%cd --date=short`.chomp
  else
    "nonlinearly"
  end
