require 'mongo'

class MongoConnector
  attr_accessor :client
  def initialize(host, database)
    @client = Mongo::Client.new([host], :database=>database)
  end

  def close
    @client.close
  end
end

class ProyectoDAO
  attr_accessor :client
  def initialize(client)
    @client = client
  end
  def add(proyecto)
    collection = @client[:proyectos]
    collection.insert_one(proyecto.to_json)
  end
  def modify(proyecto)
    collection = @client[:proyectos]
    collection.update_one(
      {:_id=>BSON::ObjectId.from_string(proyecto.id)},
      {:$set=>proyecto.to_json}
    )
  end

  def list
    collection = @client[:proyectos]
    proyectos = []
    collection.find.each do |document|
      puts document[:nombre]
      proyecto = Proyecto.new
      proyecto.id = document[:_id]
      proyecto.nombre = document[:nombre]
      proyecto.ciclo = document[:ciclo]
      proyecto.descripcion = document[:descripcion]
      proyecto.curso = document[:curso]
      proyecto.estado = document[:estado]
      proyectos.push proyecto
    end
    proyectos
  end

  def delete(id)
    collection = @client[:proyectos]
    collection.delete_one(
      {:_id=>BSON::ObjectId.from_string(id)}
    )
  end

  def get(id)
    collection = @client[:proyectos]
    document = collection.find(
      {:_id=>BSON::ObjectId.from_string(id)}).first
    proyecto = Proyecto.new
    proyecto.id = document[:_id]
    proyecto.nombre = document[:nombre]
    proyecto.ciclo = document[:ciclo]
    proyecto.descripcion = document[:descripcion]
    proyecto.curso = document[:curso]
    proyecto.estado = document[:estado]
    proyecto
  end
end

class CursoDAO
  attr_accessor :client
  def initialize(client)
    @client = client
  end
  def list
    collection = @client[:cursos]
    cursos = []
    collection.find.each do |document|
      curso = Curso.new
      curso.id = document[:_id]
      curso.nombre = document[:nombre]
      curso.estado = document[:estado]
      cursos.push curso
    end
    cursos
  end
end