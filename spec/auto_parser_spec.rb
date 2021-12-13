require 'spec_helper'
require_relative '../app/helpers/publicacion_parser'

describe 'Autoparser' do
  let(:mensaje) { 'Ford,fiesta,1999,abc-2334' }
  let(:auto) { JSON.parse(AutoParser.new.a_json(mensaje)) }

  it 'Al parsear obtengo la marca ' do
    expect(auto['marca']).to eq 'Ford'
  end

  it 'Al parsear obtengo el modelo ' do
    expect(auto['modelo']).to eq 'fiesta'
  end

  it 'Al parsear obtengo el año' do
    expect(auto['anio']).to eq 1999
  end

  it 'Al parsear obtengo la patente' do
    expect(auto['patente']).to eq 'abc-2334'
  end
end
