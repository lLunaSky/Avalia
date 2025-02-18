class AvaliacoesController < ApplicationController
  def index
    file = File.read(Rails.root.join('db', 'classes.json'))
    @avaliacoes = JSON.parse(file)
  end

  def show
    file = File.read(Rails.root.join('db', 'classes.json'))
    avaliacoes = JSON.parse(file)

    @avaliacao = avaliacoes.find { |a| a["code"] == params[:id] }

    # Perguntas fixas
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

  def submit
    @avaliacao = Avaliacao.find_by(codigo: params[:id])

    if @avaliacao.nil?
      flash[:alert] = "Avaliação não encontrada."
      redirect_to avaliacoes_path and return
    end

    params[:respostas].each do |pergunta, resposta|
      Resposta.create!(
        avaliacao: @avaliacao,
        pergunta: pergunta,
        resposta: resposta,
        usuario: "Usuário Teste" # Substitua pelo usuário autenticado caso tenha login
      )
    end

    flash[:notice] = "Avaliação enviada com sucesso!"
    redirect_to avaliacoes_path
  end
end
