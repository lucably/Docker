Datalhamentos:

# O que é uma Imagem?

Na imagem possui tudo que a sua aplicação precise para rodar possuindo:

1. Um Sistema Operacional - OS;
2. Bliblotecas;
3. Arquivos que seu App utilizará;
4. Variaveis de ambiente;

1) Para CRIAR uma imagem basta rodar => docker build -t {NOME_IMAGEM}:{NUMERO_VERSAO}
   obs: não é obrigado a ter o numero da versão exp: docker build -t minha_image ou docker build -t minha_image:1

2) Para DELETAR uma imagem => docker image remove {MINHA_IMAGEM}:{NUMERO_VERSAO}

3) Para RENOMEAR uma imagem => docker image tag {MINHA_IMAGEM}:{NUMERO_VERSAO} e digita o novo nome {MINHA_IMAGEM}:{NUMERO_VERSAO}
   obs: um exp: docker image tag minha_image docker minha_image:v1.0.0

4) Para VISUALIZAR suas imagens basta rodar => "docker images"

# O que é um Container?

Um processo que roda dentro de uma maquina, o Container é criado a partir de uma imagem.

1. Para Visualiza-la "docker ps" ou se quiser ver todas ja rodadas "docker ps -a"

2. Para rodar um container basta executar docker run -dp 3000:3000 --name {NOME_CONTAINER} {NOME_IMAGEM}

Resumindo,
Temos um APP, dentro do APP criamos um DOCKERFILE que no qual, gera uma IMAGEM. Da IMAGEM podemos construir/deletar/pausar/retornar um
CONTAINER.

APP -> IMAGEM -> CONTAINER

3. Para saber os logs do container basta executar => "docker logs --help"

4. Para executar comandos dentro do container basta executar => docker exec {NOME_CONTAINER} {COMANDO_LINXUS}
   exp: docker exec {NOME_CONTAINER} ls

5. Para inciar e parar containers basta executar => docker stop {NOME_CONTAINER} (para parar); docker start {NOME_CONTAINER} (volta a funcionar)

6. Para excluir o container basta executar => docker rm --help. Mas caso queira excluir um container em execução: docker rm -f {NOME_CONTAINER}

# UTILIZAÇÃO DE VOLUMES:

1. Para CRIAR um volume => docker volume create {NOME_VOLUME}

2. Para VISUALIZAR as informações do seu volume => docker volume inspect {NOME_VOLUME}

3. Para associar um VOLUME ao seu CONTAINER => docker run -dp 3000:3000 --name {NOME_CONTAINER} -v {NAME_VOLUME}:/app/dados {MINHA_IMAGEM}
   obs: meu_volume: /app/dados, este "/app/dados" é o diretório da sua maquina local que salvara os dados para ser mandando para o container na hora da de todas as criações.
   exp: docker run -dp 3000:3000 --name kiwi -v app-dados:/app/dados app:v2
   Nesta linha vc esta criando um container com nome "kiwi" rodando background(nao travando o terminal), usando o volume chamado "app-dados" adicionando ele dentro da pasta "app/dados" do container e utilizando a imagem "app:v2" na versao 2.

4. Para conferir se foi criado com sucesso, execute => docker exec -it {NOME_CONTAINER} sh
   obs: De um "ls" e ve se seu volume foi criado.
   exp: "ls" ve que terá a pasta "dados" dentro do seu container e se entrar dentro dela n terá nenhum dado (pq nao adicionamos nada).

5. Entre no DIRETORIO /app/dados e crie um arquivo de texto la com o comando => echo hi docker > docker.txt

6. Depois dê um "ls" vc verá que tem um arquivo chamando docker.txt, executando agora um "cat docker.txt" vc vera um "hi docker" no terminal.

Para testar se funcionou, delete seu container e crie um outro com outro nome porem utilizando o volume, vc vera que ele possui ainda o arquivo docker.txt dentro da pasta /app/dados.

7. Copiando arquivos do container para minha maquina ou vice versa basta executar => docker cp {NOME_CONTAINER} {NOME_MAQUINA}
   exp: Vamos criar um arquivo chamado teste.txt e copia-lo para minha maquina
   7.1) docker exec -it kiwi sh (supondo que exista o container chamado "kiwi").
   7.2) echo hi docker > teste.txt
   7.3) ls (para ve se o arquivo foi criado)
   7.4) Agora saia do seu container e execute na sua maquina o comando => docker cp kiwi:/app/teste.txt . (o "." quer dizer para mandar para o diretorio atual na minha maquina, provavelmente para minha IDE).
   7.5) Confira agora se o arquivo "teste.txt" esta sendo listado na minha IDE aberta (que eu executei os comandos docker).
   7.6) O contario seria este o comando => docker cp teste.txt kiwi:/app

# O que é o Dockerfile?

FROM => Qual Imagem ele irá rodar, qual o OS e qual a plataforma (node, python) etc...

WORKDIR => Significa qual o diretório ele usará, "Trabalhe neste diretório".

COPY/ADD => Adiciona quais arquivos ele usara na imagem PASTA_LOCAL -> IMAGEM.

ADD => Serve para copiar algo de algum site ou zip => exp: ADD https:teste.com.br/teste.json . ou ADD teste.zip . (lembrando q tem origiem = https:teste.com.br/teste.json e teste.zip e o destino = .)

RUN => Rode este processo, serve para colocar a aplicação em funcionamento.

ENV => O que vc precisa para rodar a aplicação (Variaveis de ambiente).

EXPOSE => Responsavel pelo controle da porta que irá usar. Exp: localhost:3000. A porta 3000 o expose que adiciona.

USER => Qual usuario que vai executar a aplicação.

CMD/ENTRYPOINT => Quando a aplicação estiver funcionando qual comando ela irá executar.

# O que é DOCKER COMPOSE:

Suponha que vc tenha uma aplicação que possui as partes de Frontend, backend e DB. Seria legal ter um container para cada aplicação, para isso utilizamos o docker-compose.

1. Para rodar basta executar o comando => docker-compose up

O que é o docker-compose.yml?

É uma linguagem muito utilizadas para escrever arquivos de configurações de cima para baixo em uma sequencia lógica.

VERSION => Versao do docker-compose, no momento utilizamos a 3.8:
version: "3.8"

SERVICES => Os serições utilizados. Recomendação: liste todos os seus serviços utilizados na identação e tambem o volume utilizado na aplicacao chamado vidly, no exemplo dado, faça:

services:
  frontend:
  backend:
  db:
volumes:
  vidly:

Explorando agora cada container, pegando o frontend e o backend.

FRONTEND/BACKEND => Se reparar dentro da pasta possui um arquivo Dockerfile, entao ao inves de ter que declarar tudo de novo basta utilizar o arquivo Dockerfile dentro da pasta frontend, utilizando o "build", ficando assim.

services:
  frontend:
    build: ./frontend
  backend:
    build: ./backend
  db:

Agora pegando o container do db, iremos fazer diferente, repare que no db nao tem um arquivo Dockerfile, entao declaramos qual a image que ele ira utilizar;

services:
  frontend:
    build: ./frontend
  backend:
    build: ./backend
  db:
    image: mongo:4.0-xenial

Criaremos agora quais portas utilizaremos em cada serviço. Porém, dentro do db temos um volume especifico para ele que chamara vidly e está dentro do arquivo /data/db

services:
  frontend:
    build: ./frontend
    ports: 
      - 3000:3000
  backend:
    build: ./backend
    ports: 
      - 3001:3001
  db:
    image: mongo:4.0-xenial
    ports: 
      - 27017:27017
    volumes: 
      - vidly:/data/db

Agora temos as variaveis de ambiente, e as dependencias.

version: "3.8"

services:
  frontend:
    depends_on: 
      - backend
    build: ./frontend
    ports: 
      - 3000:3000

  backend:
    depends_on: 
      - db
    build: ./backend
    ports: 
      - 3001:3001
    environment:
      DB_URL: mongodb://db/vidly
    command: ./docker-entrypoint.sh

  db:
    image: mongo:4.0-xenial
    ports: 
      - 27017:27017
    volumes: 
      - vidly:/data/db

volumes:
  vidly:
