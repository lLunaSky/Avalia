Feature: Redefinir Senha
  Como Usuário
  Quero redefinir uma senha para o meu usuário a partir do e-mail recebido após a solicitação da troca de senha
  A fim de recuperar o meu acesso ao sistema

  Scenario: Solicitar redefinição de senha com sucesso
    Given eu sou um usuário registrado com o e-mail "usuario@example.com"
    When eu solicito a redefinição de senha
    Then eu devo receber um e-mail com o link para redefinir a senha
    And o link deve conter um token único de redefinição

  Scenario: Redefinir senha com sucesso a partir do e-mail
    Given eu recebi um e-mail com o link para redefinir minha senha
    When eu acesso o link para redefinição
    And eu insiro minha nova senha "novaSenha123" e confirmo
    Then minha senha deve ser alterada com sucesso
    And eu devo ver a mensagem "Senha redefinida com sucesso!"

  Scenario: Tentativa de redefinição com token inválido
    When eu acesso o link de redefinição com um token inválido
    Then eu devo ver a mensagem "Link inválido ou expirado."