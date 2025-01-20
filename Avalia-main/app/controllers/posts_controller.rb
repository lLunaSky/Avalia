class PostsController < ApplicationController
    def index
        @posts = Post.all  # Recupera todos os posts do banco de dados
    end

    def new
        @post = Post.new  # Inicializa um novo objeto Post
    end

    def create
        @post = Post.new(post_params)  # Cria um novo Post com os dados do formulário
        if @post.save
            redirect_to posts_path, notice: 'Post criado com sucesso!'  # Redireciona para a lista de posts
        else
            render :new  # Se não salvar, volta para o formulário
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)  # Permite os parâmetros title e content
    end
end