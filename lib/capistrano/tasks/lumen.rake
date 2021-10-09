namespace :lumen do
	
	desc "Run Artisan migrate task"
	task :migrate do
		on roles(:web) do
			within release_path do
				execute :php, 'artisan migrate', '--force'
			end
		end
	end

	desc "Run Artisan db:seed task"
	task :seed do
		on roles(:web) do
			within release_path do
				execute :php, 'artisan db:seed'
			end
		end
	end

	desc "Run Artisan cache:clear task"
	task :clear_cache do
		on roles(:web) do
			within release_path do
				execute :php, 'artisan cache:clear'
			end
		end
	end

	desc "Run Artisan clear-compiled & optimize task"
	task :optimize do
		on roles(:web) do
			within release_path do
				execute :php, 'artisan clear-compiled'
				execute :php, 'artisan optimize'
			end
		end
	end

	desc "Create Storage directories & Set permissions task"
	task :permissions do
		on roles(:web) do
			within release_path do

				execute :chmod, '-R 777 storage/app'
				execute :chmod, '-R 777 storage/framework'
				execute :chmod, '-R 777 storage/logs'
			end
		end
	end
end