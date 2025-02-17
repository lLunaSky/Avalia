Given("eu sou um usuário registrado com o e-mail {string}") do |email|
  @usuario = Usuario.create(email: email, senha: 'senha123')
end

When("eu solicito a redefinição de senha") do
  visit '/solicitar_redefinicao_senha'
  fill_in 'email', with: @usuario.email
  click_button 'Solicitar Redefinição'
end

Then("eu devo receber um e-mail com o link para redefinir a senha") do
  email = ActionMailer::Base.deliveries.last
  expect(email.to).to include(@usuario.email)
  expect(email.body).to include('redefinir_senha')
end

Then("o link deve conter um token único de redefinição") do
  email = ActionMailer::Base.deliveries.last
  expect(email.body).to include(@usuario.token_redefinicao_senha)
end

Given("eu recebi um e-mail com o link para redefinir minha senha") do
  @usuario.enviar_instrucoes_redefinicao_senha
end

When("eu acesso o link para redefinição") do
  visit redefinir_senha_path(token: @usuario.token_redefinicao_senha)
end

When("eu insiro minha nova senha {string} e confirmo") do |nova_senha|
  fill_in 'nova_senha', with: nova_senha
  fill_in 'confirmar_senha', with: nova_senha
  click_button 'Redefinir Senha'
end

Then("minha senha deve ser alterada com sucesso") do
  @usuario.reload
  expect(@usuario.validar_senha('novaSenha123')).to be_truthy
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end

When("eu acesso o link de redefinição com um token inválido") do
  visit redefinir_senha_path(token: 'token_invalido')
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end
