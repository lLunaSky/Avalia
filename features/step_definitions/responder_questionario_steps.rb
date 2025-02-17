Given("eu sou um participante da turma {string}") do |nome_turma|
  @turma = Turma.create(nome: nome_turma)
  @participante = Participante.create(nome: 'João Silva', turma: @turma)
end

Given("existe um formulário {string} associado à turma {string}") do |nome_formulario, nome_turma|
  @formulario = Formulario.create(nome: nome_formulario, turma: @turma)
end

Given("o formulário contém as perguntas:") do |table|
  table.hashes.each do |pergunta|
    Pergunta.create(formulario: @formulario, texto: pergunta['Pergunta'])
  end
end

When("eu acesso o formulário {string}") do |nome_formulario|
  visit formulario_path(@formulario)
end

When("eu respondo as perguntas com:") do |table|
  table.hashes.each do |resposta|
    fill_in resposta['Pergunta'], with: resposta['Resposta']
  end
end

When("eu envio as minhas respostas") do
  click_button 'Enviar Respostas'
end

Then("minhas respostas devem ser salvas no sistema") do
  expect(Resposta.count).to eq(2)
  expect(Resposta.first.texto).to eq('Muito satisfeito')
  expect(Resposta.last.texto).to eq('Bom')
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end
