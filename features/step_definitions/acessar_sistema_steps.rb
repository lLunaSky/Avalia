Given("eu sou um usuário com o e-mail {string} e a senha {string}") do |email, senha|
  @usuario = Usuario.create(email: email, senha: senha, tipo: 'usuario')
end

Given("eu sou um usuário com a matrícula {string} e a senha {string}") do |matricula, senha|
  @usuario = Usuario.create(matricula: matricula, senha: senha, tipo: 'usuario')
end

Given("eu sou um administrador com o e-mail {string} e a senha {string}") do |email, senha|
  @usuario = Usuario.create(email: email, senha: senha, tipo: 'admin')
end

When("eu acesso a página de login") do
  visit '/login'
end

When("eu preencho o e-mail {string} e a senha {string}") do |email, senha|
  fill_in 'email', with: email
  fill_in 'senha', with: senha
end

When("eu preencho a matrícula {string} e a senha {string}") do |matricula, senha|
  fill_in 'matricula', with: matricula
  fill_in 'senha', with: senha
end

When("eu clico em {string}") do |botao|
  click_button botao
end

Then("eu devo ser redirecionado para a página inicial do sistema") do
  expect(current_path).to eq('/inicio')
end

Then("eu não devo ver a opção de gerenciamento no menu lateral") do
  expect(page).not_to have_content('Gerenciamento')
end

Then("eu devo ver a opção de gerenciamento no menu lateral") do
  expect(page).to have_content('Gerenciamento')
end
