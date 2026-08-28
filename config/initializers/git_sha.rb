# frozen_string_literal: true

# the important part is figuring out this path from where the app is running
REVISIONS_LOGFILE = "../../revisions.log"

GIT_SHA =
  if Rails.env.production? && File.exist?(revisions_logfile)
    `tail -1 #{revisions_logfile}`.chomp.split(" ")[3].gsub(/\)$/, "")
  elsif Rails.env.development? || Rails.env.test?
    `git rev-parse HEAD`.chomp
  else
    `pwd`
  end
  # if revision file exists, pull the peices,
  # if it doesn't exist but git is installed, pull from git,
  # no git && no revision file, be generic "unknown today etc"

BRANCH =
  if Rails.env.production? && File.exist?(revisions_logfile)
    `tail -1 #{revisions_logfile}`.chomp.split(" ")[1]
  elsif Rails.env.development? || Rails.env.test?
    `git rev-parse --abbrev-ref HEAD`.chomp
  else
    `pwd`
  end

LAST_DEPLOYED =
  if Rails.env.production? && File.exist?(revisions_logfile)
    deployed = `tail -1 #{revisions_logfile}`.chomp.split(" ")[7]
    Date.parse(deployed).strftime("%d %B %Y")
  else
    "Not in kansas anymore"
  end
