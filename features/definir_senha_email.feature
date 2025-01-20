Feature: Definir senha a partir do e-mail de solicitação de cadastro
  Como Usuário
  Quero definir uma senha para o meu usuário a partir do e-mail do sistema de solicitação de cadastro
  A fim de acessar o sistema

  Scenario: Solicitar cadastro e receber o e-mail para definir senha
    Given eu sou um usuário convidado com o e-mail "usuario@example.com"
    When eu recebo o e-mail de solicitação de cadastro
    Then o e-mail deve conter um link único para definir uma senha
    And o link deve conter um token único de ativação

  Scenario: Definir senha com sucesso a partir do link
    Given eu recebi o e-mail de solicitação de cadastro
    When eu acesso o link para definir minha senha
    And eu insiro minha nova senha "senha123" e confirmo
    Then minha conta deve ser ativada com sucesso
    And eu devo ver a mensagem "Senha definida com sucesso! Você já pode acessar o sistema."

  Scenario: Tentativa de definir senha com token inválido
    When eu acesso o link de definição de senha com um token inválido
    Then eu devo ver a mensagem "Link inválido ou expirado."