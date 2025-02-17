Feature: Acessar o sistema com e-mail ou matrícula e senha
  Como Usuário do sistema
  Quero acessar o sistema utilizando um e-mail ou matrícula e uma senha já cadastrada
  A fim de responder formulários ou gerenciar o sistema

  Scenario: Acessar com e-mail e senha
    Given eu sou um usuário com o e-mail "usuario@example.com" e a senha "senha123"
    When eu acesso a página de login
    And eu preencho o e-mail "usuario@example.com" e a senha "senha123"
    And eu clico em "Entrar"
    Then eu devo ser redirecionado para a página inicial do sistema
    And eu não devo ver a opção de gerenciamento no menu lateral

  Scenario: Acessar com matrícula e senha
    Given eu sou um usuário com a matrícula "123456" e a senha "senha123"
    When eu acesso a página de login
    And eu preencho a matrícula "123456" e a senha "senha123"
    And eu clico em "Entrar"
    Then eu devo ser redirecionado para a página inicial do sistema
    And eu não devo ver a opção de gerenciamento no menu lateral

  Scenario: Acessar como Administrador
    Given eu sou um administrador com o e-mail "admin@example.com" e a senha "admin123"
    When eu acesso a página de login
    And eu preencho o e-mail "admin@example.com" e a senha "admin123"
    And eu clico em "Entrar"
    Then eu devo ser redirecionado para a página inicial do sistema
    And eu devo ver a opção de gerenciamento no menu lateral