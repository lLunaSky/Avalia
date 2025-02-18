Given("existe um template chamado {string} criado pelo administrador") do |nome_template|
  @template = Template.create(nome: nome_template)
end

Given("existe um formulário associado ao {string}") do |nome_template|
  @formulario = Formulario.create(nome: 'Formulário de Avaliação', template: @template)
end

Given("não existe um template chamado {string}") do |nome_template|
  Template.find_by(nome: nome_template).should be_nil
end

When("eu acesso a página de gerenciamento de templates") do
  visit '/templates'
end

When("eu edito o template chamado {string} para {string}") do |nome_antigo, nome_novo|
  within("#template-#{@template.id}") do
    click_link 'Editar'
  end
  fill_in 'template_nome', with: nome_novo
  click_button 'Atualizar Template'
end

When("eu deleto o template chamado {string}") do |nome_template|
  within("#template-#{@template.id}") do
    click_link 'Deletar'
  end
end

When("eu tento editar o template chamado {string}") do |nome_template|
  visit "/templates/invalid_id/edit"
end

When("eu tento deletar o template chamado {string}") do |nome_template|
  visit "/templates/invalid_id"
  click_link 'Deletar'
end

Then("o template deve ser atualizado com o novo nome") do
  expect(@template.reload.nome).to eq("Novo Nome")
end