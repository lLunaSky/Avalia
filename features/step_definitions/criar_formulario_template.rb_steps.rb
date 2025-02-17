Given("eu sou um administrador com o e-mail {string} e a senha {string}") do |email, senha|
  @admin = Usuario.create(email: email, senha: senha, tipo: 'admin')
  visit '/login'
  fill_in 'email', with: @admin.email
  fill_in 'senha', with: senha
  click_button 'Entrar'
end

Given("existem os templates {string} e {string}") do |template1, template2|
  @template1 = Template.create(nome: template1)
  @template2 = Template.create(nome: template2)
end

Given("a turma {string} está disponível para seleção") do |nome_turma|
  @turma = Turma.create(nome: nome_turma)
end

When("eu acesso a página de criação de formulário") do
  visit '/formularios/new'
end

When("eu escolho o template {string}") do |template|
  select template, from: 'formulario_template_id'
end

When("eu seleciono a turma {string}") do |turma|
  select turma, from: 'formulario_turma_id'
end

When("eu preencho os dados necessários para o formulário") do
  fill_in 'formulario_nome', with: 'Formulário de Avaliação'
  fill_in 'formulario_descricao', with: 'Avaliação de desempenho da turma'
  fill_in 'formulario_data_inicio', with: '2023-10-01'
  fill_in 'formulario_data_termino', with: '2023-10-31'
end

When("eu clico em {string}") do |botao|
  click_button botao
end

Then("o formulário deve ser criado com sucesso para a turma {string}") do |turma|
  expect(page).to have_content('Formulário criado com sucesso')
  expect(Formulario.last.turma.nome).to eq(turma)
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end

Then("eu devo ver o formulário listado na página de gerenciamento de formulários") do
  visit '/formularios'
  expect(page).to have_content('Formulário de Avaliação')
end
