require 'sinatra'
require_relative 'models/models'
require_relative 'models/dao'
require_relative 'config' 

get '/proyecto' do
  connector = MongoConnector.new MONGO_HOST, MONGO_DATABASE
  connector = 
  cursoDAO = CursoDAO.new connector.client 
  cursos = cursoDAO.list
  connector.close

  erb :proyecto, :layout=>:main, :locals=>{:tipo=>'nuevo', :cursos=>cursos}
end

get '/proyecto/modificar' do
  connector = MongoConnector.new MONGO_HOST, MONGO_DATABASE
  proyectoDAO = ProyectoDAO.new connector.client
  proyecto = proyectoDAO.get params[:id]
  cursoDAO = CursoDAO.new connector.client
  cursos = cursoDAO.list
  connector.close

  erb :proyecto, :layout=>:main, 
    :locals=>{
      :proyecto=>proyecto, :tipo=>'modificar', :cursos=>cursos
    } 
end

get '/proyecto/eliminar' do
  connector = MongoConnector.new MONGO_HOST, MONGO_DATABASE
  proyectoDAO = ProyectoDAO.new connector.client
  proyectoDAO.delete params[:id] 
  connector.close

  redirect '/proyecto/listar'
end

get '/proyecto/listar' do
  # proyectos = [
  #   {:nombre=>"Proyecto 1", :ciclo=>"2017-1"},
  #   {:nombre=>"Proyecto 2", :ciclo=>"2017-1"},
  #   {:nombre=>"Proyecto 3", :ciclo=>"2017-2"},
  #   {:nombre=>"Proyecto 4", :ciclo=>"2017-2"},
  #   {:nombre=>"Proyecto 5", :ciclo=>"2017-2"},
  # ]
  connector = MongoConnector.new MONGO_HOST, MONGO_DATABASE
  proyectoDAO = ProyectoDAO.new connector.client
  proyectos = proyectoDAO.list 
  connector.close

  erb :lista_proyectos, :layout=>:main, :locals=>{:proyectos=>proyectos}
end

post '/proyecto' do
  connector = MongoConnector.new MONGO_HOST, MONGO_DATABASE
  if params[:tipo] == 'nuevo'
    proyecto = Proyecto.new
    proyecto.nombre = params[:nombre]
    proyecto.ciclo = params[:ciclo]
    proyecto.descripcion = params[:descripcion]
    proyecto.curso = params[:curso]
    proyecto.estado = 'A'
  
    
    proyectoDAO = ProyectoDAO.new connector.client
    proyectoDAO.add proyecto
    connector.close
  
    redirect '/proyecto/listar' 
  else
    proyecto = Proyecto.new
    proyecto.id = params[:id]
    proyecto.nombre = params[:nombre]
    proyecto.ciclo = params[:ciclo]
    proyecto.descripcion = params[:descripcion]
    proyecto.curso = params[:curso]
    proyecto.estado = 'A'
  
    
    proyectoDAO = ProyectoDAO.new connector.client
    proyectoDAO.modify proyecto
    connector.close
  
    redirect '/proyecto/listar' 

  end
  

end
