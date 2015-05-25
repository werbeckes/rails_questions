namespace :scheduler do
  desc "TODO"
  task send_daily_emails: :environment do
    User.send_daily_emails
  end

end
