Sequel.migration do
    up do
        create_table(:cursos) do
            primary_key :id
            String :nombre, :null=>false, :size=>50
            String :estado, :null=>false, :size=>1
        end
    end

    down do
        drop_table(:cursos)
    end
end