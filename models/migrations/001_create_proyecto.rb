Sequel.migration do
    up do
        create_table(:proyectos) do
            primary_key :id
            String :nombre, :null=>false, :size=>50
            String :ciclo, :null=>false, :size=>6
            String :descripcion, :null=>true, :size=>400
            String :estado, :null=>false, :size=>1
        end
    end

    down do
        drop_table(:proyectos)
    end
end