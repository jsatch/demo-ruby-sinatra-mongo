MONGO_HOST = 'localhost:27017'
MONGO_DATABASE = 'proyectos_db'
PG_HOST = 'localhost:5432'
PG_USER = 'jsatch'
PG_PASSWORD = 'jsatch'
PG_DATABASE = 'proyectosdb'
PG_URL = ENV['DATABASE_URL'] || "postgres://#{PG_USER}:#{PG_PASSWORD}@#{PG_HOST}/#{PG_DATABASE}"