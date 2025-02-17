Given("existem os formulários:") do |table|
  table.hashes.each do |formulario|
    Formulario.create(nome: formulario['Formulário'])
  end
end

Given("não existem formulários criados no sistema") do
  Formulario.destroy_all
end

Given("existe um formulário chamado {string} com respostas") do |nome_formulario|
  @formulario = Formulario.create(nome: nome_formulario)
  @resposta = Resposta.create(formulario: @formulario, participante: 'João Silva', resposta: 'Muito satisfeito')
end

When("eu acesso a página de gerenciamento de formulários") do
  visit '/formularios'
end

When("eu clico no botão de gerar relatório para o formulário {string}") do |nome_formulario|
  within("#formulario-#{@formulario.id}") do
    click_link 'Gerar Relatório'
  end
end

Then("eu devo ver os formulários listados:") do |table|
  table.hashes.each do |formulario|
    expect(page).to have_content(formulario['Formulário'])
  end
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end

Then("eu devo ser redirecionado para a página de relatório do formulário {string}") do |nome_formulario|
  expect(current_path).to eq(relatorio_formulario_path(@formulario))
end
