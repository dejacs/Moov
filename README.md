#### Olá, gente! :teddy_bear:

Esse é um aplicativo sobre filmes e possui as seguintes funcionalidades até então:

- Listagem dos filmes em alta
- Busca por título do filme
- Listagem do resultado da busca
- Detalhamento do filme
- Scroll infinito ao listar resultado da busca

A api utilizada foi a famosa https://api.themoviedb.org/ e o aplicativo pode funcionar em inglês ou português.

Foram feitos testes unitários para a camada de regras de negócio e testes básicos de ui com os serviços mockados.

O voice control funciona pois usei componentes nativos, mas poderia melhorar a forma que a tabela é descrita, indicar a interação com as células principalmente.

A arquitetura que usei foi a VIP-C e preferi não utilizar nenhum pod, mas no dia a dia uso `Alamofire`, `Snapkit` e `SDWebImage`.

Modularizei para deixar separada a camada de Network e também poderia criar um módulo para a parte de padrões de layout.

Deixei um worker `Storage` para trabalhar o `UserDefaults`, mas acabei não tendo a oportunidade de usar nesse app e também não o avancei muito.

Já o `Network` eu criei na metade do ano e fui alterando conforme aprendi coisas novas.

Ainda não consegui fazer o teste de ui que testasse a busca, estava muito complicado capturar o campo de busca no teste.

Eu separaria os endpoints em method, path e, se tivesse, headers.

Tentei colocar fastlane para tirar screenshots, mas não consegui concluir, precisava configurar o auto-incremento do número de build (básico).

Sobre o layout, eu mudaria a cor da status bar no detalhamento do filme e também procuraria outro campo de imagem que fosse horizontal no retorno da requisição.

É isso! :sparkles:

# Screenshots

<img width="100" alt="icon" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Screen%20Shot%202021-12-04%20at%2017.21.26.png"> 

<img width="300" alt="launchScreen" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.21.35.png">  <img width="300" alt="trendingMovies" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.21.38.png">  
<img width="300" alt="searchResult" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.21.44.png">  <img width="300" alt="portugues" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.24.14.png">
<img width="300" alt="darkMode" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.24.48.png">  <img width="300" alt="searchError" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.23.23.png">
<img width="300" alt="searchEmpty" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.23.48.png">  <img width="300" alt="searchLoading" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.23.06.png">  
<img width="300" alt="movieDetails-1" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.21.52.png">  <img width="300" alt="movieDetails-2" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.21.54.png">  
<img width="300" alt="movieDetailsLoading" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.22.13.png">  <img width="300" alt="movieDetailsError" src="https://github.com/dejacs/Moov/blob/main/ScreenShots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202021-12-04%20at%2017.22.31.png">
