# awesome_quotes_exercise

## Preparação do repositório no github

O primeiro passo tem a ver com uma limitação do github: o repositório que foi criado para ti não tem as actions 
habilitadas por omissão. Isso quer dizer que os testes não vão correr automaticamente, 
de cada vez que fazes push (mas deviam!).

Para habilitar as actions, vai ao separador "Actions" na página inicial do repositório, deve-te aparecer uma página
"Workflows aren’t being run on this forked repository". 
Deves clicar no botão "I understand my workflows, go ahead and enable them".

![actions screenshot](./docs/screenshot-actions.png)

## Objetivo

O objetivo deste exercício é desenvolver uma aplicação em flutter que mostra frases inspiradoras.

![demonstração](./docs/awesome-quotes-demo.gif)

## Exercício

Este repositório foi criado já com a estrutura (em termos de ficheiros) da aplicação, só tens que criar o código necessário
dentro desses ficheiros. Já existe algum código criado para customizar o tema da aplicação.

Está também incluído um ficheiro integration_test.dart que permite correr uma série de testes de integração. Não deves alterar
este ficheiro. Estes testes vão ser executados de cada vez que fazes push para o repositório.

Estes testes de integração assumem que alguns dos widgets têm uma chave específica associada, vê na imagem abaixo quais
são essas chaves:

![chaves dos widgets](./docs/screenshot.png)

Deves então criar a aplicação tendo em conta estes pressupostos, até que ela:
* Tenha o aspeto e comportamento apresentado na demonstração acima
* Passe os testes de integração

## Dicas técnicas

Para obteres as frases "inspiradoras" irás usar a lib [awesome_quotes](https://pub.dev/packages/awesome_quotes). Esta lib
já está incluída no pubspec.yaml.

Para a navegação deves usar uma [NavigationBar](https://api.flutter.dev/flutter/material/NavigationBar-class.html). A navegação
deve ser implementada no widget `MainPage` que deves criar no ficheiro `main_page.dart`.

Deverás criar 2 singletons: `FavoritesModel` e `QuotesService`. Note-se que, por serem singletons, devem permitir criar uma
única instância da classe, acessível através da propriedade `instance`. Ex: `FavoritesModel.instance`.

A classe `FavoritesModel` deverá ser um singleton com uma propriedade `favorites` contendo uma lista de `Quote` (esta classe
está incluída na biblioteca "awesome_quotes"). Para garantir o encapsulamento, essa propriedade deve ser apenas de leitura 
(dica: usa um getter que retorne `UnmodifiableListView` ) e deves incluir um método `addFavorite(Quote quote)`.

A classe `QuotesService` deverá ser um singleton com um método `getRandomQuote()` que retorna uma quote aleatória. Esta classe
limita-se a chamar a biblioteca "awesome_quotes". No entanto, tem uma particularidade importante para facilitar os testes - 
permite "injetar" uma quote fixa através da propriedade (da classe) `testingQuote`. Quando se injeta essa quote, a classe passar a retornar
sempre esse quote no `getRandomQuote()`.

