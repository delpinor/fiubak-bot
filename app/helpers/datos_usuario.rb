class DatosUsuario
  attr_reader :dni, :nombre, :email
  def initialize(nombre, dni, email)
    @dni = dni.to_i
    @nombre = nombre.strip
    @email = email.strip
  end

  def convertir_a_json
    {
      dni: @dni,
      nombre: @nombre,
      email: @email
    }.to_json
  end
end
