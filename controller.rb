require 'sinatra'

get '/proyecto' do
  erb :proyecto, :layout=>:main
end

get '/proyecto/listar' do
  proyectos = [
    {:nombre=>"Proyecto 1", :ciclo=>"2017-1"},
    {:nombre=>"Proyecto 2", :ciclo=>"2017-1"},
    {:nombre=>"Proyecto 3", :ciclo=>"2017-2"},
    {:nombre=>"Proyecto 4", :ciclo=>"2017-2"},
    {:nombre=>"Proyecto 5", :ciclo=>"2017-2"},
  ]
  erb :lista_proyectos, :layout=>:main, :locals=>{:proyectos=>proyectos}
end