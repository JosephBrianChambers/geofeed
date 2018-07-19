namespace :start do
  # postgres -D /usr/local/var/postgres
  task :development do
    exec 'foreman start -f Procfile.dev -p 3001'
  end

  desc 'Start production server'
  task :production do
    exec 'NPM_CONFIG_PRODUCTION=true npm run postinstall && foreman start'
  end
end

desc 'Start development server'
task :start => 'start:development'
