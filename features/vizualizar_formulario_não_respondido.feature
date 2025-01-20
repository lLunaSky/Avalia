Feature: Visualizar Formulários Não Respondidos
  Como Participante de uma turma
  Quero visualizar os formulários não respondidos das turmas em que estou matriculado
  A fim de poder escolher qual irei responder

  Scenario: Participante visualiza os formulários não respondidos
    Given sou participante das turmas:
      | Matemática |
      | Física     |
    And existem os formulários:
      | Nome do Formulário        | Turma       |
      | Formulário de Geometria   | Matemática  |
      | Formulário de Álgebra     | Matemática  |
      | Formulário de Mecânica    | Física      |
    And eu já respondi os formulários:
      | Formulário de Álgebra     |
    When eu acesso a página de formulários não respondidos
    Then eu devo ver os formulários não respondidos:
      | Formulário de Geometria   |
      | Formulário de Mecânica    |

  Scenario: Participante não tem formulários pendentes
    Given sou participante da turma:
      | Química |
    And existem os formulários:
      | Nome do Formulário        | Turma       |
      | Formulário de Química Orgânica | Química  |
    And eu já respondi os formulários:
      | Formulário de Química Orgânica |
    When eu acesso a página de formulários não respondidos
    Then eu devo ver a mensagem "Não há formulários pendentes para responder."