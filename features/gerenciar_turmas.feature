Feature: Gerenciar Turmas do Departamento
  Como Administrador
  Quero gerenciar somente as turmas do departamento ao qual eu pertenço
  A fim de avaliar o desempenho das turmas no semestre atual

  Scenario: Visualizar turmas do departamento
    Given eu sou um administrador do departamento "Matemática"
    And existem as seguintes turmas cadastradas:
      | Nome da Turma   | Departamento  | Semestre |
      | Cálculo I       | Matemática    | 2023.2   |
      | Álgebra Linear  | Matemática    | 2023.2   |
      | Física Geral I  | Física        | 2023.2   |
    When eu acesso a página de gerenciamento de turmas
    Then eu devo ver somente as turmas do departamento "Matemática":
      | Nome da Turma   | Semestre |
      | Cálculo I       | 2023.2   |
      | Álgebra Linear  | 2023.2   |

  Scenario: Filtrar turmas por semestre atual
    Given eu sou um administrador do departamento "Matemática"
    And existem as seguintes turmas cadastradas:
      | Nome da Turma   | Departamento  | Semestre |
      | Cálculo I       | Matemática    | 2023.1   |
      | Álgebra Linear  | Matemática    | 2023.2   |
      | Física Geral I  | Física        | 2023.2   |
    When eu acesso a página de gerenciamento de turmas
    And eu filtro as turmas pelo semestre "2023.2"
    Then eu devo ver somente as turmas do departamento "Matemática" no semestre "2023.2":
      | Nome da Turma   | Semestre |
      | Álgebra Linear  | 2023.2   |

  Scenario: Nenhuma turma disponível para o departamento
    Given eu sou um administrador do departamento "Química"
    And não existem turmas cadastradas para o departamento "Química"
    When eu acesso a página de gerenciamento de turmas
    Then eu devo ver a mensagem "Nenhuma turma disponível para o seu departamento no semestre atual."