Feature: Atualizar Base de Dados com Dados do SIGAA
  Como Administrador
  Quero atualizar a base de dados já existente com os dados atuais do SIGAA
  A fim de corrigir a base de dados do sistema

  Scenario: Atualizar base de dados com sucesso
    Given o sistema SIGAA está disponível
    And existem dados no SIGAA que ainda não estão na base de dados:
      | Nome           | Tipo       | Identificador |
      | Matemática     | Disciplina | 12345         |
      | Física Geral   | Disciplina | 67890         |
      | João da Silva  | Professor  | 98765         |
    When eu solicito a atualização da base de dados com os dados do SIGAA
    Then os dados devem ser atualizados com sucesso
    And eu devo ver a mensagem "Base de dados atualizada com sucesso!"

  Scenario: Falha ao atualizar base de dados devido à indisponibilidade do SIGAA
    Given o sistema SIGAA está indisponível
    When eu solicito a atualização da base de dados com os dados do SIGAA
    Then eu devo ver a mensagem "Falha ao atualizar a base de dados. O SIGAA está indisponível."

  Scenario: Base de dados já está atualizada
    Given o sistema SIGAA está disponível
    And os dados do SIGAA já estão sincronizados com a base de dados
    When eu solicito a atualização da base de dados com os dados do SIGAA
    Then eu devo ver a mensagem "Nenhuma atualização necessária. A base de dados já está sincronizada."