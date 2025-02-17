Feature: Visualizar Templates Criados
  Como Administrador
  Quero visualizar os templates criados
  A fim de poder editar e/ou deletar um template que eu criei

  Scenario: Visualizar a lista de templates criados
    Given existem os templates:
      | Template de Avaliação |
      | Template de Relatório |
    When eu acesso a página de gerenciamento de templates
    Then eu devo ver os templates listados:
      | Template de Avaliação |
      | Template de Relatório |

  Scenario: Não existem templates criados
    Given não existem templates criados no sistema
    When eu acesso a página de gerenciamento de templates
    Then eu devo ver a mensagem "Nenhum template criado ainda"

  Scenario: Acesso à edição de um template
    Given existe um template chamado "Template de Avaliação"
    When eu acesso a página de gerenciamento de templates
    And eu clico no botão de editar para o template "Template de Avaliação"
    Then eu devo ser redirecionado para a página de edição do template "Template de Avaliação"

  Scenario: Acesso à exclusão de um template
    Given existe um template chamado "Template de Relatório"
    When eu acesso a página de gerenciamento de templates
    And eu clico no botão de deletar para o template "Template de Relatório"
    Then o template "Template de Relatório" deve ser removido do sistema