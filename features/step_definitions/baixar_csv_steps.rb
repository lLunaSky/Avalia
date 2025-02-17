Given("eu sou um administrador com o e-mail {string} e a senha {string}") do |email, senha|
  @admin = Usuario.create(email: email, senha: senha, tipo: 'admin')
  visit '/login'
  fill_in 'email', with: @admin.email
  fill_in 'senha', with: senha
  click_button 'Entrar'
end

Given("o formulário {string} existe com respostas de participantes") do |nome_formulario|
  @formulario = Formulario.create(nome: nome_formulario)
  @resposta1 = Resposta.create(formulario: @formulario, participante: 'João Silva', resposta: 'Muito satisfeito')
  @resposta2 = Resposta.create(formulario: @formulario, participante: 'Maria Oliveira', resposta: 'Satisfeito')
end

When("eu acesso a página de resultados do formulário {string}") do |nome_formulario|
  visit formulario_path(@formulario)
end

When("eu clico em {string}") do |botao|
  click_link botao
end

Then("o arquivo CSV contendo as respostas do formulário deve ser baixado") do
  expect(page.response_headers['Content-Type']).to eq('text/csv')
  expect(page.response_headers['Content-Disposition']).to include('attachment')
end

Then("o conteúdo do CSV deve conter as respostas dos participantes") do
  csv_content = page.body
  expect(csv_content).to include('João Silva,Muito satisfeito')
  expect(csv_content).to include('Maria Oliveira,Satisfeito')
end
