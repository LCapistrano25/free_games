# 🎮 GameFlow

Aplicativo Flutter que consome a [RAWG Video Games Database API](https://api.rawg.io/docs/) para exibir uma vitrine moderna de jogos, plataformas e lojas. Com um layout inspirado no Twitter e navegação intuitiva, é ideal para quem quer explorar o universo dos games ou aprender como integrar APIs REST em Flutter.

---

## 🧩 Funcionalidades

- 🧪 **Tela de login simplificada** (somente um botão "Entrar")
- 🏠 **Home com múltiplas abas**: Jogos, Plataformas e Lojas
- 🔍 **Busca** de jogos, plataformas e lojas
- 🗂️ **Listagem com cards modernos**, incluindo:
  - Nome
  - Avaliação
  - Metacritic
  - Tags e gêneros
  - Imagens
- 🧾 **Telas de detalhes**:
  - Jogos: informações completas, imagens, gráficos de avaliação
  - Plataformas: jogos populares e anos de atividade
  - Lojas: jogos em destaque e visual da loja
- 📊 **Gráficos com FL Chart**
- 🔁 **Atualização manual** com botão de refresh
- 📦 **Gerenciamento de rotas nomeadas** centralizado
- 💥 **Tratamento de erros com tela personalizada**

---

## 🔧 Tecnologias Utilizadas

- [Flutter](https://flutter.dev) & [Dart](https://dart.dev)
- [`http`](https://pub.dev/packages/http) – chamadas REST
- [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) – uso seguro da chave da API
- [`fl_chart`](https://pub.dev/packages/fl_chart) – gráficos bonitos e dinâmicos
- [RAWG.io API](https://api.rawg.io/docs/) – base de dados de jogos

---

## 🚀 Como usar

1. Crie uma conta em [RAWG.io](https://rawg.io/apidocs) e gere sua **API key**
2. Crie um arquivo `.env` dentro da pasta `assets/` com o seguinte conteúdo:

   ```env
   RAWG_API_KEY=your_key_here
