require "#{File.dirname(__FILE__)}/../lib/routing"
require "#{File.dirname(__FILE__)}/../lib/version"
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
require "#{File.dirname(__FILE__)}/tarea_ofertar_p2p"
require "#{File.dirname(__FILE__)}/tarea_consultar_publicacion"
require "#{File.dirname(__FILE__)}/tarea_rechazar_oferta"
require "#{File.dirname(__FILE__)}/tarea_aceptar_oferta"
require "#{File.dirname(__FILE__)}/tarea_solicitar_test_drive"

class RutasBot
  include Routing
  extend ComandoBot

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

  procesar_patron(%r{/ofertar (?<datos>.*)}, TareaOfertarPorP2P.new)

  procesar_patron(%r{/rechazar_oferta (?<datos>.*)}, TareaRechazarOferta.new)

  procesar_patron(%r{/aceptar_oferta (?<datos>.*)}, TareaAceptarOferta.new)

  procesar_patron(%r{/consultar_publicacion (?<datos>.*)}, TareaConsultarPublicacion.new)

  procesar_patron(%r{/test_drive (?<datos>.*)}, TareaSolicitarTestDrive.new)

  default do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "No te entiendo, pero esto te puede ayudar: \n \n #{TareaAyuda.new.procesar(nil, nil)}")
  end
end
