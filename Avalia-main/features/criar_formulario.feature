Feature: Criação de formulário para avaliação de desempenho

  Como Administrador
  Eu quero escolher criar um formulário para os docentes ou discentes de uma turma
  A fim de avaliar o desempenho de uma matéria

  Scenario: Criar formulário para avaliação de docente
    Given o administrador está logado no sistema
    When ele escolhe a opção de criar um formulário para avaliação de docente
    And ele preenche os campos necessários para o formulário
    Then o formulário de avaliação de docente é criado com sucesso

  Scenario: Criar formulário para avaliação de discente
    Given o administrador está logado no sistema
    When ele escolhe a opção de criar um formulário para avaliação de discente
    And ele preenche os campos necessários para o formulário
    Then o formulário de avaliação de discente é criado com sucesso

  Scenario: Criar formulário sem preencher todos os campos obrigatórios
    Given o administrador está logado no sistema
    When ele escolhe a opção de criar um formulário
    And ele não preenche todos os campos obrigatórios
    Then o sistema exibe uma mensagem de erro indicando os campos obrigatórios não preenchidos

  Scenario: Criar formulário para avaliação com dados inválidos
    Given o administrador está logado no sistema
    When ele escolhe a opção de criar um formulário para avaliação
    And ele preenche os campos com dados inválidos (ex: data de início posterior à data de término)
    Then o sistema exibe uma mensagem de erro informando os dados inválidos
