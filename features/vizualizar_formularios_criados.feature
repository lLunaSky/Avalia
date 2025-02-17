Feature: Visualizar Formulários Criados
  Como Administrador
  Quero visualizar os formulários criados
  A fim de poder gerar um relatório a partir das respostas

  Scenario: Visualizar a lista de formulários criados
    Given existem os formulários:
      | Formulário de Avaliação |
      | Formulário de Pesquisa |
    When eu acesso a página de gerenciamento de formulários
    Then eu devo ver os formulários listados:
      | Formulário de Avaliação |
      | Formulário de Pesquisa |

  Scenario: Não existem formulários criados
    Given não existem formulários criados no sistema
    When eu acesso a página de gerenciamento de formulários
    Then eu devo ver a mensagem "Nenhum formulário criado ainda"

  Scenario: Gerar relatório de respostas de um formulário
    Given existe um formulário chamado "Formulário de Avaliação" com respostas
    When eu acesso a página de gerenciamento de formulários
    And eu clico no botão de gerar relatório para o formulário "Formulário de Avaliação"
    Then eu devo ser redirecionado para a página de relatório do formulário "Formulário de Avaliação"