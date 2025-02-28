# Sistema de Gestão de Eventos 🎉

## Sobre o Projeto 📝
Este é um aplicativo Ruby on Rails projetado para gerenciar eventos, atividades e inscrições de usuários. Ele oferece suporte à autenticação de usuários, criação de eventos, programação de atividades e gerenciamento de inscrições.

## Funcionalidades 🚀
- 🔐 Autenticação de usuários (login/logout)
- 📅 Gerenciamento de eventos (criação, edição, exclusão de eventos)
- 🎓 Gerenciamento de atividades (vinculadas a eventos)
- 📝 Inscrição de usuários em eventos
- ✅ Gerenciamento de status de inscrições

## Tecnologias Utilizadas 🛠️
- 💎 Ruby on Rails
- 🧪 RSpec (para testes)
- ✅ Shoulda Matchers (para facilitar a escrita de testes)
- 🏭 FactoryBot (para criação de dados de teste)
- 🐘 PostgreSQL (banco de dados)

## Instruções de Configuração 💻
1. Clone o repositório:
```bash
git clone https://github.com/seu-repositorio/sistema-de-gestao-de-eventos.git
cd sistema-de-gestao-de-eventos
```
2. Instale as dependências:
```bash
bundle install
```
3. Configure o banco de dados:
```bash
rails db:create
rails db:migrate
rails db:seed
```
4. Rode o servidor:
```bash
rails server
```
5. Acesse a aplicação em `http://localhost:3000`

## Executando os Testes 🧑‍💻
Para rodar a suíte de testes:
```bash
rspec
```

## Contribuindo 🤝
1. Faça um fork do repositório
2. Crie uma branch para sua funcionalidade (`git checkout -b feature/SuaFuncionalidade`)
3. Faça commit das suas alterações (`git commit -m 'Adiciona nova funcionalidade'`)
4. Envie para a branch remota (`git push origin feature/SuaFuncionalidade`)
5. Abra um Pull Request

## Licença 📄
Este projeto é open-source e está disponível sob a [Licença MIT](LICENSE).
