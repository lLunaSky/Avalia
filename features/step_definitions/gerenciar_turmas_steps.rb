# features/step_definitions/gerenciar_turmas_steps.rb

Given("eu sou um administrador do departamento {string}") do |departamento|
  @admin = Usuario.create(email: 'admin@example.com', senha: 'admin123', tipo: 'admin', departamento: departamento)
  visit '/login'
  fill_in 'email', with: @admin.email
  fill_in 'senha', with: 'admin123'
  click_button 'Entrar'
end

Given("existem as seguintes turmas cadastradas:") do |table|
  table.hashes.each do |turma|
    Turma.create(nome: turma['Nome da Turma'], departamento: turma['Departamento'], semestre: turma['Semestre'])
  end
end

Given("não existem turmas cadastradas para o departamento {string}") do |departamento|
  Turma.where(departamento: departamento).destroy_all
end

When("eu acesso a página de gerenciamento de turmas") do
  visit '/turmas'
end

When("eu filtro as turmas pelo semestre {string}") do |semestre|
  select semestre, from: 'semestre'
  click_button 'Filtrar'
end

Then("eu devo ver somente as turmas do departamento {string}:") do |departamento, table|
  table.hashes.each do |turma|
    expect(page).to have_content(turma['Nome da Turma'])
    expect(page).to have_content(turma['Semestre'])
  end
  expect(page).not_to have_content('Física Geral I')
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end
