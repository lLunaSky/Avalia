require 'json'

class AvaliacoesController < ApplicationController
  def index
    file = File.read(Rails.root.join('db', 'classes.json'))
    @avaliacoes = JSON.parse(file)
  end

  def show
    file = File.read(Rails.root.join('db', 'classes.json'))
    avaliacoes = JSON.parse(file)

    # Busca a avaliação pelo código da turma
    @avaliacao = avaliacoes.find { |a| a["code"] == params[:id] }

    # Simulação das perguntas associadas à avaliação
    @perguntas = [
      { id: 1, texto: "Como você avalia o professor?", tipo: "opcoes" },
      { id: 2, texto: "O que poderia ser melhorado?", tipo: "texto" },
      { id: 3, texto: "Como você avalia a estrutura da disciplina?", tipo: "opcoes" }
    ]

    unless @avaliacao
      flash[:alert] = "Avaliação não encontrada!"
      redirect_to avaliacoes_path
    end
  end
end
