require 'spec_helper'
require_relative '../../app/helpers/rechazar_oferta_parser.rb'

describe 'Rechazo oferta parser' do
  let(:mensaje) { '123,45000' }
  let(:rechazo_oferta) { RechazarOfertaParser.new.a_json(mensaje) }

  it 'Al parsear tengo el id_publicacion' do
    expect(JSON.parse(rechazo_oferta)['id_publicacion']).to eq 123
  end

  it 'Al parsear tengo el precio al que publico despues de rechazar' do
    expect(JSON.parse(rechazo_oferta)['precio']).to eq 45_000
  end
end
