Given("o sistema SIGAA está disponível") do
  @sigaa_disponivel = true
end

Given("o sistema SIGAA está indisponível") do
  @sigaa_disponivel = false
end

Given("existem dados no SIGAA que ainda não estão na base de dados:") do |table|
  @dados_sigaa = table.hashes
end

Given("os dados do SIGAA já estão sincronizados com a base de dados") do
  @dados_sincronizados = true
end

When("eu solicito a atualização da base de dados com os dados do SIGAA") do
  if @sigaa_disponivel
    if @dados_sincronizados
      @mensagem = "Nenhuma atualização necessária. A base de dados já está sincronizada."
    else
      @dados_sigaa.each do |dado|
        Disciplina.create(nome: dado['Nome'], tipo: dado['Tipo'], identificador: dado['Identificador'])
      end
      @mensagem = "Base de dados atualizada com sucesso!"
    end
  else
    @mensagem = "Falha ao atualizar a base de dados. O SIGAA está indisponível."
  end
end

Then("os dados devem ser atualizados com sucesso") do
  expect(Disciplina.count).to eq(@dados_sigaa.size)
end

Then("eu devo ver a mensagem {string}") do |mensagem|
  expect(@mensagem).to eq(mensagem)
end
