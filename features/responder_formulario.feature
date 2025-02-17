Feature: Responder questionário sobre a turma
  Como Participante de uma turma
  Quero responder o questionário sobre a turma em que estou matriculado
  A fim de submeter minha avaliação da turma

  Scenario: Responder a todas as perguntas do questionário
    Given eu sou um participante da turma "Matemática 101"
    And existe um formulário "Avaliação da Turma" associado à turma "Matemática 101"
    And o formulário contém as perguntas:
      | Qual é o seu nível de satisfação com o professor? |
      | Como você avalia o material didático utilizado?   |
    When eu acesso o formulário "Avaliação da Turma"
    And eu respondo as perguntas com:
      | Qual é o seu nível de satisfação com o professor? | Muito satisfeito |
      | Como você avalia o material didático utilizado?   | Bom              |
    And eu envio as minhas respostas
    Then minhas respostas devem ser salvas no sistema
    And eu devo ver a mensagem "Formulário enviado com sucesso!"