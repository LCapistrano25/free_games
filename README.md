# 🎮 Games App

Aplicativo Flutter que consome a [RAWG Video Games Database API](https://api.rawg.io/docs/) para exibir uma lista de jogos populares com informações como nome, imagem de capa, data de lançamento e avaliação. Ideal para usuários que querem descobrir novos jogos e para desenvolvedores que desejam aprender a integrar APIs REST no Flutter.

---

## 🧩 Funcionalidades

- 🔍 **Busca de jogos** por nome
- 🗂️ **Listagem de jogos** com:
  - Nome do jogo
  - Data de lançamento
  - Avaliação média
  - Imagem de fundo
- 🔁 **Atualização manual** dos dados com botão de refresh

---

## 🔧 Tecnologias Utilizadas

- [Flutter](https://flutter.dev) & [Dart](https://dart.dev)
- [`http`](https://pub.dev/packages/http) – para chamadas HTTP
- [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) – para gerenciamento seguro da chave da API
- [RAWG.io API](https://api.rawg.io/docs/) – fonte de dados sobre jogos

---

## 🚀 Como usar

1. Crie uma conta em [RAWG.io](https://rawg.io/apidocs) e gere sua **API key**
2. Adicione um arquivo `.env` dentro da pasta `assets/` com o seguinte conteúdo:

