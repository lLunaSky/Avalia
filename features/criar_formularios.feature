Feature: Criar formulário baseado em um template para as turmas
  Como Administrador
  Quero criar um formulário baseado em um template para as turmas que eu escolher
  A fim de avaliar o desempenho das turmas no semestre atual

  Scenario: Criar um formulário para a turma selecionada
    Given eu sou um administrador com o e-mail "admin@example.com" e a senha "admin123"
    And existem os templates "Template de Avaliação" e "Template de Relatório"
    And a turma "Turma A" está disponível para seleção
    When eu acesso a página de criação de formulário
    And eu escolho o template "Template de Avaliação"
    And eu seleciono a turma "Turma A"
    And eu preencho os dados necessários para o formulário
    And eu clico em "Criar Formulário"
    Then o formulário deve ser criado com sucesso para a turma "Turma A"
    And eu devo ver a mensagem "Formulário criado com sucesso"
    And eu devo ver o formulário listado na página de gerenciamento de formulários