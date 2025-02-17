Given("existem os templates:") do |table|
  table.hashes.each do |template|
    Template.create(nome: template['Template'])
  end
end

Given("não existem templates criados no sistema") do
  Template.destroy_all
end

Given("existe um template chamado {string}") do |nome_template|
  @template = Template.create(nome: nome_template)
end

When("eu acesso a página de gerenciamento de templates") do
  visit '/templates'
end

When("eu clico no botão de editar para o template {string}") do |nome_template|
  within("#template-#{@template.id}") do
    click_link 'Editar'
  end
end

When("eu clico no botão de deletar para o template {string}") do |nome_template|
  within("#template-#{@template.id}") do
    click_link 'Deletar'
  end
end

Then("eu devo ver os templates listados:") do |table|
  table.hashes.each do |template|
    expect(page).to have_content(template['Template'])
  end
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end

Then("eu devo ser redirecionado para a página de edição do template {string}") do |nome_template|
  expect(current_path).to eq(edit_template_path(@template))
end

Then("o template {string} deve ser removido do sistema") do |nome_template|
  expect(Template.find_by(nome: nome_template)).to be_nil
end
