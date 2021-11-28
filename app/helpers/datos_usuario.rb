class DatosUsuario
  attr_reader :dni, :nombre, :email
  def initialize(nombre, dni, email)
    @dni = dni.to_i
    @nombre = nombre.strip
    @email = email.strip
  end
end
