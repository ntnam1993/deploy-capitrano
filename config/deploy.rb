# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'LMS'
# set :repo_url, 'git@bitbucket.org:nldanang/ncr-backend.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# ask :branch, 'develop'.chomp
set :branch, ENV['branch'] || 'develop'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/html/ncr-backend'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('.env')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('storage', 'vendor')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

    # after :restart, :clear_cache do
    #   on roles(:web), in: :groups, limit: 3, wait: 10 do
    #     # Here we can do anything such as:
    #     # within release_path do
    #     #   execute :rake, 'cache:clear'
    #     # end
    #   end
    # end

    desc 'LMS Admin'
    task :lms_admin do
        on roles(:web) do

            set :repo_url, 'git@bitbucket.org:nldanang/lms_admin.git'
            set :deploy_to, '/var/www/html/lms_admin'

            set :linked_files, fetch(:linked_files, []).push('.env')
            set :linked_dirs, fetch(:linked_dirs, []).push('storage', 'vendor')
            set :linked_dirs, fetch(:linked_dirs, []).push('public/adminer')
            set :linked_dirs, fetch(:linked_dirs, []).push('public/temp')
            set :file_permissions_paths, ["public/temp"]

            invoke :deploy
        end
    end

    desc 'LMS Backend'
    task :lms_backend do
        on roles(:web) do

            set :repo_url, 'git@bitbucket.org:nldanang/lms_backend.git'
            set :deploy_to, '/var/www/html/lms_backend'

            set :linked_files, fetch(:linked_files, []).push('.env')
            set :linked_dirs, fetch(:linked_dirs, []).push('storage', 'vendor')

            invoke :deploy
        end
    end

    desc 'luxspiral dev'
    task :luxspiral_dev do
        on roles(:web) do

            set :repo_url, 'git@bitbucket.org:work-house/server_cms.git'
            set :deploy_to, '/var/www/html/luxspiral'

            set :linked_files, fetch(:linked_files, []).push('.env')
            set :linked_dirs, fetch(:linked_dirs, []).push('storage', 'vendor')
            set :linked_dirs, fetch(:linked_dirs, []).push('public/adminer')
            set :linked_dirs, fetch(:linked_dirs, []).push('public/upload')
            set :file_permissions_paths, ["public/upload", "bootstrap", "storage","public/callback","public"]
            set :file_permissions_chmod_mode, "0777"

            invoke :deploy
        end
    end

    desc 'luxspiral stg'
    task :luxspiral_stg do
        on roles(:web) do

            set :repo_url, 'git@bitbucket.org:work-house/server_cms.git'
            set :deploy_to, '/var/www/html/luxspiral'

            set :linked_files, fetch(:linked_files, []).push('.env')
            set :linked_dirs, fetch(:linked_dirs, []).push('storage', 'vendor')
            set :linked_dirs, fetch(:linked_dirs, []).push('public/upload')
            set :file_permissions_paths, ["public/upload", "bootstrap", "storage","public/callback","public"]

            invoke :deploy
        end
    end

    desc 'luxspiral pro'
        task :luxspiral_pro do
            on roles(:web) do

                set :repo_url, 'git@bitbucket.org:work-house/server_cms.git'
                set :deploy_to, '/var/www/html/luxspiral'

                set :linked_files, fetch(:linked_files, []).push('.env')
                set :linked_dirs, fetch(:linked_dirs, []).push('storage', 'vendor')
                set :linked_dirs, fetch(:linked_dirs, []).push('public/upload')
                set :file_permissions_paths, ["public/upload", "bootstrap", "storage", "public/callback","public"]

                invoke :deploy
            end
        end

    after :luxspiral_dev, 'composer:install'
    after :luxspiral_dev, 'composer:update'
    after :luxspiral_dev, 'composer:dump_autoload'
    after :luxspiral_dev, 'lumen:migrate'
    #after :luxspiral_dev, 'lumen:seed'

    after :luxspiral_pro, 'composer:install'
    after :luxspiral_pro, 'composer:dump_autoload'
    after :luxspiral_pro, 'lumen:migrate'
    #after :luxspiral_pro, 'lumen:seed'

    after :luxspiral_stg, 'composer:install'
    after :luxspiral_stg, 'composer:dump_autoload'
    after :luxspiral_stg, 'lumen:migrate'
    #after :luxspiral_stg, 'lumen:seed'

    #after :lms_admin, 'composer:install'
    after :lms_admin, 'composer:update'
    after :lms_admin, 'composer:dump_autoload'

     #after :lms_backend, 'composer:install'
     after :lms_backend, 'composer:update'
     after :lms_backend, 'composer:dump_autoload'
     #after :lms_backend, 'lumen:migrate'
     #after :lms_backend, 'lumen:seed'
     #after :lms_backend', 'supervisord:reload'
end
