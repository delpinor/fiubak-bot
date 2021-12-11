class FabricaEmoji
  EMOJIS = { auto: "\u{1F697}", item: "\u{27A1}", plata: "\u{1F4B2}" }.freeze
  def self.emoji(tipo)
    EMOJIS[tipo]
  end
end
