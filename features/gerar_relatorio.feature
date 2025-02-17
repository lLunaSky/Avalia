Feature: Baixar CSV com os resultados de um formulário
  Como Administrador
  Quero baixar um arquivo CSV contendo os resultados de um formulário
  A fim de avaliar o desempenho das turmas

  Scenario: Baixar CSV com os resultados do formulário
    Given eu sou um administrador com o e-mail "admin@example.com" e a senha "admin123"
    And o formulário "Formulário de Avaliação" existe com respostas de participantes
    When eu acesso a página de resultados do formulário "Formulário de Avaliação"
    And eu clico em "Baixar CSV"
    Then o arquivo CSV contendo as respostas do formulário deve ser baixado
    And o conteúdo do CSV deve conter as respostas dos participantes