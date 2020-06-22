namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :settings do |_t, args|
    require 'sequel/core'
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      db.extension(:schema_dumper)

      schema_path = File.expand_path('../../db/schema.rb', __dir__)
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      File.open(schema_path, 'w') { |f| f.write db.dump_schema_migration(indexes: true, foreign_keys: true) }
    end
  end
end
