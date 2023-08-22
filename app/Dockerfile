FROM node:12-alpine

WORKDIR /app

#Para melhorar a performace, copia primeiro o package.json e depois executa as builds, pois assim ele vera que nao tem mudança e nao precisa fazer nenhuma instalação. Depois eu copio todos os arquivos.
COPY package.json . 

RUN apk add --no-cache python2 g++ make
RUN yarn install --production

COPY . . 

CMD ["node", "src/index.js"]

EXPOSE 3000
