class Proyecto
  attr_accessor :id,:nombre, :ciclo, :curso, :descripcion, :estado
  def to_json
    {
      :nombre=>@nombre, 
      :ciclo=>@ciclo, 
      :descripcion=>@descripcion, 
      :estado=>@estado, 
      :curso=>@curso
    }
  end
end

class Curso
  attr_accessor :id, :nombre, :estado
  def to_json
    {
      :nombre=>@nombre,
      :estado=>@estado
    }
  end
end