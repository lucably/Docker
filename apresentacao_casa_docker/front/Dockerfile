FROM node:12-alpine

WORKDIR /app

#Para melhorar a performace, copia primeiro o package.json e depois executa as builds, pois assim ele vera que nao tem mudança e nao precisa fazer nenhuma instalação. Depois eu copio todos os arquivos.
COPY package.json . 

RUN npm install

EXPOSE 3000

COPY . . 

CMD ["npm", "start"]
