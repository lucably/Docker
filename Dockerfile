#Qual imagem vc quer usar obs: "alpine" é uma distribuição linux, assim como Ubuntu, Debian, Centos etc...
FROM node:alpine

#Copiar a partir de qual diretorio do seu projeto e mandar para qual diretorio dentro do container
COPY . /app

#Em qual diretorio o container vai procurar para começar a trabalhar
WORKDIR /app

#Se eu fosse rodar sem o "WORKDIR" o comando executavel seria CMD node /app/testeHello.js.
CMD node testeHello.js   

#---------------------------------Criacao da Imagem------------------------------------------------------------------------------------
#Comandos para criação de images: "docker build -t hi-docker ."
#Obs: o "-t" é para criar uma tag, um nome para a imagem que no caso é "hi-docker" o "." é para saber a partir de qual diretorio e para criar q no caso é o direito atual que estou


#---------------------------------Criacao do Container---------------------------------------------------------------------------------
#Rodar uma imagem e criar um container => "docker run {NOME_IMAGEM}" Nesta opção ele roda uma vez e se ngm usar ele mata a aplicação
#Possui tambem o interativo, "docker run -it {NOME_IMAGEM}" Nesta ele fica executando até desligarmos manualmente o container


#----------------------------------Baixar uma Imagem------------------------------------------------------------------------------------
# "docker pull {NOME_IMAGEM}" Exmp: "docker run ubuntu", caso queira entrar diretamente na aplicação (no terminal do container) executa o comando "docker run -it ubuntu"