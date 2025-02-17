Given("eu sou um administrador com o e-mail {string} e a senha {string}") do |email, senha|
  @admin = Usuario.create(email: email, senha: senha, tipo: 'admin')
  visit '/login'
  fill_in 'email', with: @admin.email
  fill_in 'senha', with: senha
  click_button 'Entrar'
end

When("eu acesso a página de criação de template de formulário") do
  visit '/templates/new'
end

When("eu preencho o nome do template como {string}") do |nome_template|
  fill_in 'template_nome', with: nome_template
end

When("eu adiciono as questões {string} e {string}") do |questao1, questao2|
  fill_in 'template_questoes', with: "#{questao1}\n#{questao2}"
end

When("eu clico em {string}") do |botao|
  click_button botao
end

Then("o template de formulário {string} deve ser criado com sucesso") do |nome_template|
  expect(page).to have_content('Template criado com sucesso')
  expect(Template.last.nome).to eq(nome_template)
end

Then("as questões {string} e {string} devem estar associadas ao template") do |questao1, questao2|
  template = Template.last
  expect(template.questoes).to include(questao1)
  expect(template.questoes).to include(questao2)
end

Then("eu devo ver o template {string} na lista de templates") do |nome_template|
  visit '/templates'
  expect(page).to have_content(nome_template)
end
