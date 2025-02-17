Given("eu sou um usuário convidado com o e-mail {string}") do |email|
  @usuario = Usuario.create(email: email, convidado: true)
end

When("eu recebo o e-mail de solicitação de cadastro") do
  @usuario.enviar_instrucoes_definir_senha
end

Then("o e-mail deve conter um link único para definir uma senha") do
  email = ActionMailer::Base.deliveries.last
  expect(email.body).to include('definir_senha')
end

Then("o link deve conter um token único de ativação") do
  email = ActionMailer::Base.deliveries.last
  expect(email.body).to include(@usuario.token_definir_senha)
end
Given("eu recebi o e-mail de solicitação de cadastro") do
  @usuario.enviar_instrucoes_definir_senha
end

When("eu acesso o link para definir minha senha") do
  visit definir_senha_path(token: @usuario.token_definir_senha)
end

When("eu insiro minha nova senha {string} e confirmo") do |senha|
  fill_in 'nova_senha', with: senha
  fill_in 'confirmar_senha', with: senha
  click_button 'Definir Senha'
end

Then("minha conta deve ser ativada com sucesso") do
  @usuario.reload
  expect(@usuario.convidado).to be_falsey
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end

When("eu acesso o link de definição de senha com um token inválido") do
  visit definir_senha_path(token: 'token_invalido')
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end
