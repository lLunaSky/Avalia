Given("o administrador está logado no sistema") do
  @admin = Usuario.create(email: 'admin@example.com', senha: 'admin123', tipo: 'admin')
  visit '/login'
  fill_in 'email', with: @admin.email
  fill_in 'senha', with: 'admin123'
  click_button 'Entrar'
end

When("ele escolhe a opção de criar um formulário para avaliação de docente") do
  visit '/formularios/new'
  choose 'formulario_tipo_docente'
end

When("ele escolhe a opção de criar um formulário para avaliação de discente") do
  visit '/formularios/new'
  choose 'formulario_tipo_discente'
end

When("ele preenche os campos necessários para o formulário") do
  fill_in 'formulario_nome', with: 'Formulário de Avaliação de Docente'
  fill_in 'formulario_descricao', with: 'Avaliação de desempenho dos docentes'
  fill_in 'formulario_data_inicio', with: '2023-10-01'
  fill_in 'formulario_data_termino', with: '2023-10-31'
  click_button 'Criar Formulário'
end

When("ele não preenche todos os campos obrigatórios") do
  fill_in 'formulario_nome', with: ''
  fill_in 'formulario_descricao', with: ''
  click_button 'Criar Formulário'
end

When("ele preenche os campos com dados inválidos") do
  fill_in 'formulario_nome', with: 'Formulário Inválido'
  fill_in 'formulario_descricao', with: 'Avaliação com datas inválidas'
  fill_in 'formulario_data_inicio', with: '2023-11-01'
  fill_in 'formulario_data_termino', with: '2023-10-01'
  click_button 'Criar Formulário'
end

Then("o formulário de avaliação de docente é criado com sucesso") do
  expect(page).to have_content('Formulário criado com sucesso!')
  expect(Formulario.last.tipo).to eq('docente')
end

Then("o formulário de avaliação de discente é crido")
