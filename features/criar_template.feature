Feature: Criar template de formulário com questões
  Como Administrador
  Quero criar um template de formulário contendo as questões do formulário
  A fim de gerar formulários de avaliações para avaliar o desempenho das turmas

  Scenario: Criar um template de avaliação com questões
    Given eu sou um administrador com o e-mail "admin@example.com" e a senha "admin123"
    When eu acesso a página de criação de template de formulário
    And eu preencho o nome do template como "Template de Avaliação"
    And eu adiciono as questões "Qual é o seu nível de satisfação?" e "Como você avalia o desempenho do professor?"
    And eu clico em "Criar Template"
    Then o template de formulário "Template de Avaliação" deve ser criado com sucesso
    And as questões "Qual é o seu nível de satisfação?" e "Como você avalia o desempenho do professor?" devem estar associadas ao template
    And eu devo ver o template "Template de Avaliação" na lista de templates