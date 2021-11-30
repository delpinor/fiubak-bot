require "#{File.dirname(__FILE__)}/../lib/routing"

module ComandoBot
  include Routing::ClazzMethods

  def procesar_comando(comando, tarea)
    respuesta_comando(comando, tarea)
  end

  def procesar_patron(patron, tarea)
    respuesta_patron(patron, tarea)
  end

  private

  def respuesta_patron(patron, tarea)
    on_message_pattern patron do |bot, message, args|
      respuesta = tarea.procesar(args['datos'], message.chat.id)
      bot.api.send_message(chat_id: message.chat.id, text: respuesta)
    end
  end

  def respuesta_comando(comando, tarea)
    on_message comando do |bot, message|
      respuesta = tarea.procesar(nil, message.chat.id)
      bot.api.send_message(chat_id: message.chat.id, text: respuesta)
    end
  end
end
