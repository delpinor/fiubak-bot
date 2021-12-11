require_relative '../app/tarea'

class TareaSaludar < Tarea
  def procesar(message, _datos = nil)
    'Hola ' + message.from.first_name + " #{FabricaEmoji.emoji(:alegre)}"
  end
end
