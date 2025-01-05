document.getElementById('botaoteste').addEventListener('click', function() {
    const newDiv = document.createElement('div');
      
      // Adiciona algum conteúdo ou estilo à nova div (opcional)
      newDiv.textContent = 'Nova Div Criada!';
      newDiv.style.margin = '10px';
      newDiv.style.padding = '10px';
      newDiv.style.backgroundColor = '#f0f0f0';
      newDiv.style.border = '1px solid #ccc';
  
      // Adiciona a nova div ao contêiner
      container.appendChild(newDiv);
});