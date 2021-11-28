class DatosUsuario
  attr_reader :dni
  def initialize(_nombre, dni, _email)
    @dni = dni.to_i
  end
end
