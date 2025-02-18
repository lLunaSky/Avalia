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
    puts "========== RECEBENDO PARÂMETROS =========="
    puts params.inspect

    @avaliacao = Avaliacao.find_by(codigo: params[:id])
    puts "Avaliação encontrada? #{@avaliacao.inspect}"

    if @avaliacao.nil?
      flash[:alert] = "Avaliação não encontrada."
      redirect_to avaliacoes_path and return
    end

    # Definição das perguntas fixas para obter o texto completo
    perguntas_fixas = {
      "1" => "Como você avalia o professor?",
      "2" => "O que poderia ser melhorado?",
      "3" => "Como você avalia a estrutura da disciplina?"
    }

    params[:respostas].each do |pergunta_id, resposta|
      pergunta_texto = perguntas_fixas[pergunta_id] # Pegando o texto correto da pergunta

      puts "Salvando resposta: #{pergunta_texto} - #{resposta}" # Debugando salvamento

      resposta_obj = Resposta.create(
        avaliacao: @avaliacao,
        pergunta: pergunta_texto,
        resposta: resposta,
        usuario: "Usuário Teste"
      )

      if resposta_obj.persisted?
        puts "Resposta salva com sucesso: #{resposta_obj.inspect}"
      else
        puts "Erro ao salvar resposta: #{resposta_obj.errors.full_messages}"
      end
    end

    flash[:notice] = "Avaliação enviada com sucesso!"
    redirect_to avaliacoes_path
  end
end
