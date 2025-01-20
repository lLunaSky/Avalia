Feature: Cadastrar participantes de turmas ao importar usuários do SIGAA
  Como Administrador
  Quero cadastrar participantes de turmas do SIGAA ao importar dados de usuários novos para o sistema
  A fim de que eles acessem o sistema CAMAAR

  Scenario: Importar usuários do SIGAA e associá-los a turmas
    Given eu sou um administrador com o e-mail "admin@example.com" e a senha "admin123"
    And existe uma turma "Turma de Matemática" no sistema
    When eu importo um arquivo CSV com os usuários do SIGAA
    And o arquivo contém os dados dos usuários: "João Silva, joao@example.com, Turma de Matemática" e "Maria Oliveira, maria@example.com, Turma de Matemática"
    Then os usuários "João Silva" e "Maria Oliveira" devem ser cadastrados no sistema
    And eles devem ser associados à turma "Turma de Matemática"