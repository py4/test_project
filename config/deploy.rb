# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'test_project'
set :repo_url, 'git@github.com:py4/test_project.git'
set :deploy_to, '/var/www/test_project'
set :scm, :git
set :branch, "master"
set :user, "ubuntu"
set :ssh_options, keys: ["/home/pooya/.ssh/Pooyatesttask.pem"]
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :keep_releases, 5
set :pty, true

server "52.74.109.174", user: "ubuntu", roles: [:app, :web, :db], :primary => true

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc "Symlink shared config file"
  task :symlink_config_files do
    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end



end
