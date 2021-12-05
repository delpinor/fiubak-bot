require "#{File.dirname(__FILE__)}/../lib/routing"
require "#{File.dirname(__FILE__)}/../lib/version"
require "#{File.dirname(__FILE__)}/tv/series"
require "#{File.dirname(__FILE__)}/api/web_api"
require "#{File.dirname(__FILE__)}/helpers/usuario_parser"
require "#{File.dirname(__FILE__)}/comando_bot"
require "#{File.dirname(__FILE__)}/tarea_ayuda"
require "#{File.dirname(__FILE__)}/tarea_registrar_usuario"
require "#{File.dirname(__FILE__)}/tarea_registrar_auto"
require "#{File.dirname(__FILE__)}/tarea_consultar_intencion_de_venta"
require "#{File.dirname(__FILE__)}/tarea_saludar"
require "#{File.dirname(__FILE__)}/tarea_busqueda"
require "#{File.dirname(__FILE__)}/tarea_aceptar_cotizacion"
require "#{File.dirname(__FILE__)}/tarea_publicar_por_p2p"

class RutasBot
  include Routing
  extend ComandoBot

  on_message '/start' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "Hola, #{message.from.first_name}")
  end

  on_message_pattern %r{/say_hi (?<name>.*)} do |bot, message, args|
    bot.api.send_message(chat_id: message.chat.id, text: "Hola, #{args['name']}")
  end

  on_message '/stop' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "Chau, #{message.from.username}")
  end

  on_message '/stop' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "Chau, #{message.from.username}")
  end

  procesar_comando('Hola', TareaSaludar.new)

  procesar_comando('hola', TareaSaludar.new)

  procesar_comando('/ayuda', TareaAyuda.new)

  procesar_comando('/busqueda', TareaBusqueda.new)

  procesar_comando('/búsqueda', TareaBusqueda.new)

  procesar_patron(%r{/registrar (?<datos>.*)}, TareaRegistrarUsuario.new)

  procesar_patron(%r{/nueva_venta (?<datos>.*)}, TareaRegistrarAuto.new)

  procesar_patron(%r{/consultar_estado (?<datos>.*)}, TareaConsultarIntencionDeVenta.new)

  procesar_patron(%r{/aceptar_cotizacion (?<datos>.*)}, TareaAceptarCotizacion.new)

  procesar_patron(%r{/publicar (?<datos>.*)}, TareaPublicarPorP2P.new)

  on_message '/time' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "La hora actual es, #{Time.now}")
  end

  on_message '/tv' do |bot, message|
    kb = Tv::Series.all.map do |tv_serie|
      Telegram::Bot::Types::InlineKeyboardButton.new(text: tv_serie.name, callback_data: tv_serie.id.to_s)
    end
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)

    bot.api.send_message(chat_id: message.chat.id, text: 'Quien se queda con el trono?', reply_markup: markup)
  end

  on_message '/busqueda_centro' do |bot, message|
    kb = [
      Telegram::Bot::Types::KeyboardButton.new(text: 'Compartime tu ubicacion', request_location: true)
    ]
    markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
    bot.api.send_message(chat_id: message.chat.id, text: 'Busqueda por ubicacion', reply_markup: markup)
  end

  on_location_response do |bot, message|
    response = "Ubicacion es Lat:#{message.location.latitude} - Long:#{message.location.longitude}"
    puts response
    bot.api.send_message(chat_id: message.chat.id, text: response)
  end

  on_response_to 'Quien se queda con el trono?' do |bot, message|
    response = Tv::Series.handle_response message.data
    bot.api.send_message(chat_id: message.message.chat.id, text: response)
  end

  on_message '/version' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: Version.current)
  end

  default do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Uh? No te entiendo! Me repetis la pregunta?')
  end
end
