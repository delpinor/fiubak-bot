class FabricaEmoji
  EMOJIS = { auto: "\u{1F697}",
             item: "\u{27A1}",
             plata: "\u{1F4B2}",
             revision: "\u{1F6E0}",
             revisado_cotizado: "\u{1F4B5}",
             vendido: "\u{1F91D}",
             rechazado: "\u{1F6AB}",
             publicado: "\u{1F4E2}" }.freeze
  def self.emoji(tipo)
    EMOJIS[tipo]
  end
end
