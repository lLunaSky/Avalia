Given("sou participante das turmas:") do |table|
  table.hashes.each do |turma|
    @turma = Turma.create(nome: turma['Turma'])
    @participante = Participante.create(nome: 'João Silva', turma: @turma)
  end
end

Given("existem os formulários:") do |table|
  table.hashes.each do |formulario|
    turma = Turma.find_by(nome: formulario['Turma'])
    Formulario.create(nome: formulario['Nome do Formulário'], turma: turma)
  end
end

Given("eu já respondi os formulários:") do |table|
  table.hashes.each do |formulario|
    formulario = Formulario.find_by(nome: formulario['Nome do Formulário'])
    Resposta.create(participante: @participante, formulario: formulario)
  end
end

When("eu acesso a página de formulários não respondidos") do
  visit '/formularios_nao_respondidos'
end

Then("eu devo ver os formulários não respondidos:") do |table|
  table.hashes.each do |formulario|
    expect(page).to have_content(formulario['Nome do Formulário'])
  end
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end
