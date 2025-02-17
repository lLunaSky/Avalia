Given("eu sou um administrador com o e-mail {string} e a senha {string}") do |email, senha|
  @admin = Usuario.create(email: email, senha: senha, tipo: 'admin')
end

Given("existe uma turma {string} no sistema") do |nome_turma|
  @turma = Turma.create(nome: nome_turma)
end

When("eu importo um arquivo CSV com os usuários do SIGAA") do
  @arquivo_csv = Tempfile.new(['usuarios', '.csv'])
  @arquivo_csv.write("Nome,Email,Turma\nJoão Silva,joao@example.com,Turma de Matemática\nMaria Oliveira,maria@example.com,Turma de Matemática")
  @arquivo_csv.close
end

When("o arquivo contém os dados dos usuários: {string} e {string}") do |usuario1, usuario2|
  # Os dados já foram escritos no arquivo CSV no passo anterior
end

Then("os usuários {string} e {string} devem ser cadastrados no sistema") do |usuario1, usuario2|
  expect(Usuario.find_by(nome: usuario1)).not_to be_nil
  expect(Usuario.find_by(nome: usuario2)).not_to be_nil
end

Then("eles devem ser associados à turma {string}") do |nome_turma|
  turma = Turma.find_by(nome: nome_turma)
  expect(turma.usuarios.count).to eq(2)
end
