# Exercício Flutter - awesome quotes

## Objetivo

O objetivo deste exercício é desenvolver uma aplicação em flutter que mostra frases inspiradoras.

![demonstração](./docs/awesome-quotes-demo.gif)

## Exercício

Este repositório foi criado já com a estrutura (em termos de ficheiros) da aplicação, só tens que criar o código necessário
dentro desses ficheiros. Já existe algum código criado para customizar o tema da aplicação.

Estão também incluídos dois ficheiros test/widget_test.dart e integration_test/integration_test.dart que 
permitem correr uma série de testes de widget/integração. Não deves alterar
estes ficheiros. Deves, no entanto, utilizá-los para validar localmente que implementaste corretamente a aplicação. 

Além disso, estes testes vão ser executados de cada vez que fazes push para o repositório[^1].

Estes testes assumem que alguns dos widgets têm uma chave específica associada, vê na imagem abaixo quais
são essas chaves:

![chaves dos widgets](./docs/screenshot.png)

Deves então criar a aplicação tendo em conta estes pressupostos, até que ela:
* Tenha o aspeto e comportamento apresentado na demonstração acima
* Passe os testes de widget e integração

## Pressupostos

Este exercício pressupõe que sabes o que são testes de integração e sabes usar o Provider. Se ainda não o fizeste,
vê o vídeo [Desenvolvimento com widgets em flutter - parte 5](https://www.youtube.com/watch?v=22WyA_NVkLk).

Pressupõe igualmente que saber o que é o padrão Observer/Observable e como usá-lo em Flutter. Se ainda não o fizeste,
vê o vídeo [Desenvolvimento com widgets em flutter - parte 6](https://www.youtube.com/watch?v=6n9qzEjSlzs).

## Dicas técnicas

Para obteres as frases "inspiradoras" irás usar a lib [awesome_quotes](https://pub.dev/packages/awesome_quotes). Esta lib
já está incluída no pubspec.yaml.

Para a navegação deves usar uma [NavigationBar](https://api.flutter.dev/flutter/material/NavigationBar-class.html). A navegação
deve ser implementada no widget `MainPage` que deves criar no ficheiro `main_page.dart`.

Deverás implementar 2 classes: `FavoritesModel` e `QuotesService` (as classes já existem mas estão vazias). Estas classes
não deverão ser Singletons, pois isso prejudica a sua testabilidade. Em vez disso, devem ser instanciadas no main() e injetadas
na aplicação através de um `MultiProvider`. A lib `Provider` já está incluída no pubspec.yaml.

Como estas 2 classes são injetadas, nunca as deves instanciar no `QuotePage` e `FavoritesPage`, em vez disso deves usar o 
`context.read()` para as obteres.

A classe `FavoritesModel` deve incluir uma propriedade `favorites` contendo uma lista de `Quote` (esta classe
está incluída na biblioteca "awesome_quotes"). Para garantir o encapsulamento, essa propriedade deve ser apenas de leitura
(dica: usa um getter que retorne `UnmodifiableListView` ) e deves incluir um método `addFavorite(Quote quote)`.  
Além disso, esta classe deve ser observável, e chamadas ao `addFavorite(Quote quote)` devem avisar os observadores que o
o estado do objeto foi modificado.

A classe `QuotesService` deverá incluir um método `getRandomQuote()` que retorna uma quote aleatória. Esta classe
limita-se a chamar a biblioteca "awesome_quotes". Parece uma classe desnecessária (porque não colocar o widget a chamar 
diretamente a biblioteca?) mas vai permitir que os testes usem um `FakeQuoteService` que retorna sempre a mesma quote.
Vê as primeiras linhas do `widget_test.dart` para perceberes do que estamos a falar.

Nota que há quotes bastante grandes (com muitos carateres). Deves ter o cuidado de garantir que o texto da quote cabe sempre no ecrã
sem fazer overflow.

Se reparares, o código do testes de widget é praticamente igual aos do testes de integração. No entanto, os testes de widget
correm muito mais rápido, por isso recomendamos que executes esses testes em vez dos de integração. No entanto, pode haver
erros difíceis de diagnosticar nos testes de widget que se tornam mais óbvios nos testes de integração pois consegues ver
no emulador aquilo que está a ser testado.

[^1]: Por razões de desempenho, neste momento, os testes de integração não estão a ser executados no github.

