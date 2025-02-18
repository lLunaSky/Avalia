# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'

# Caminho do arquivo JSON
file_path = Rails.root.join('db', 'classes.json')

if File.exist?(file_path)
  file = File.read(file_path)
  avaliacoes = JSON.parse(file)

  puts "Inserindo avaliações no banco..."

  avaliacoes.each do |avaliacao|
    Avaliacao.find_or_create_by!(codigo: avaliacao["code"]) do |a|
      a.nome = avaliacao["name"]
      a.semestre = avaliacao["class"]["semester"]
    end
  end

  puts "Avaliações importadas com sucesso!"
else
  puts "Arquivo JSON não encontrado!"
end
