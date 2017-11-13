Sequel.migration do
    up do
        alter_table :proyectos do
            add_foreign_key :curso_id, :cursos
        end
    end

    down do
        drop_column :proyectos, :curso_id
    end
end