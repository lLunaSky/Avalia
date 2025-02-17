require 'json'

class AvaliacoesController < ApplicationController
  def index
    file = File.read(Rails.root.join('db', 'classes.json'))
    @avaliacoes = JSON.parse(file)
  end
end
