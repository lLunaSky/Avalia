Feature: Gerenciamento de Templates
  Como Administrador
  Quero editar e/ou deletar um template que eu criei sem afetar os formulários já criados
  A fim de organizar os templates existentes

  Scenario: Editar um template com sucesso
    Given existe um template chamado "Template de Avaliação" criado pelo administrador
    And existe um formulário associado ao "Template de Avaliação"
    When eu acesso a página de gerenciamento de templates
    And eu edito o template chamado "Template de Avaliação" para "Template Atualizado"
    Then o template deve ser atualizado com o novo nome
    And o formulário associado ao template deve permanecer inalterado

  Scenario: Deletar um template sem afetar formulários
    Given existe um template chamado "Template de Relatório" criado pelo administrador
    And existe um formulário associado ao "Template de Relatório"
    When eu acesso a página de gerenciamento de templates
    And eu deleto o template chamado "Template de Relatório"
    Then o template deve ser removido do sistema
    And os formulários associados ao template devem permanecer inalterados

  Scenario: Tentativa de editar um template inexistente
    Given não existe um template chamado "Template Inexistente"
    When eu tento editar o template chamado "Template Inexistente"
    Then eu devo ver a mensagem "Template não encontrado"

  Scenario: Tentativa de deletar um template inexistente
    Given não existe um template chamado "Template Inexistente"
    When eu tento deletar o template chamado "Template Inexistente"
    Then eu devo ver a mensagem "Template não encontrado"