class TareaSaludar
  def procesar(message, _datos = nil)
    'Hola ' + message.from.first_name
  end
end
