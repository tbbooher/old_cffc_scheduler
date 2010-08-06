set :application, "scheduler"
set :deploy_to, "/var/www/scheduler.crossfitadaptation.com"
set :rails_env, "development"
set :keep_releases, 2

set :scm, :git
set :repository, "/Users/Tim/Sites/cfa/scheduler/.git/"
set :branch, "master"
set :deploy_via, :copy
set :rake, "/var/lib/gems/1.8/bin/rake"

#server "schedule.crossfitadaptation.com", :app, :web, :db, :primary => true
server "69.164.218.233", :app, :web, :db, :primary => true

default_run_options[:pty] = true 

set :user, 'passenger'
set :ssh_options, { :forward_agent => true }

 namespace :deploy do
   desc "Restarting mod_rails with the nifty restart.txt"   
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

after :deploy, "deploy:cleanup"
