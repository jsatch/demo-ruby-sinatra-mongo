require 'sequel'
require 'pg'

class PGConnector
    attr_accessor :client
    def initialize(host, database, user, password)
        @client = Sequel.connect("postgres://#{user}:#{password}@#{host}/#{database}")
    end

    def initialize(database_url)
        @client = Sequel.connect(database_url)
    end
    
    def close
        @client.disconnect
    end
end

class ProyectoPGDAO
    attr_accessor :client
    def initialize(client)
        @client = client
    end
    def add(proyecto)
        @client[:proyectos].insert(
            :nombre=>proyecto.nombre,
            :ciclo=>proyecto.ciclo,
            :descripcion=>proyecto.descripcion,
            :estado=>proyecto.estado,
            :curso_id=>proyecto.curso
        )
    end
    def modify(proyecto)
        @client[:proyectos].where(
            :id=>proyecto.id
        ).update(
            :nombre=>proyecto.nombre,
            :ciclo=>proyecto.ciclo,
            :descripcion=>proyecto.descripcion,
            :estado=>proyecto.estado,
            :curso_id=>proyecto.curso
        )
    end
  
    def list
        proyectos = []
        @client[:proyectos].all.each do |proy|
            proyecto = Proyecto.new
            proyecto.id = proy[:id]
            proyecto.nombre = proy[:nombre]
            proyecto.ciclo = proy[:ciclo]
            proyecto.descripcion = proy[:descripcion]
            proyecto.curso = proy[:curso]
            proyecto.estado = proy[:estado]
            proyectos.push proyecto
        end
        proyectos
    end
  
    def delete(id)
        @client[:proyectos].where(
            :id=>id
        ).delete
    end
  
    def get(id)
        proy = @client[:proyectos].first(:id=>id)
        proyecto = Proyecto.new
        proyecto.id = proy[:id]
        proyecto.nombre = proy[:nombre]
        proyecto.ciclo = proy[:ciclo]
        proyecto.descripcion = proy[:descripcion]
        proyecto.curso = proy[:curso]
        proyecto.estado = proy[:estado]
        proyecto
    end
end

class CursoPGDAO
    attr_accessor :client
    def initialize(client)
        @client = client
    end
    def list
        cursos = []
        @client[:cursos].all.each do |cur|
            curso = Curso.new
            curso.id = cur[:id]
            curso.nombre = cur[:nombre]
            curso.estado = cur[:estado]
            cursos.push curso
        end
        cursos
    end
end