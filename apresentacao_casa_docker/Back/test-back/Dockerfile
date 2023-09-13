FROM node:20-alpine3.18

WORKDIR /app

#Para melhorar a performace, copia primeiro o package.json e depois executa as builds, pois assim ele vera que nao tem mudança e nao precisa fazer nenhuma instalação. Depois eu copio todos os arquivos.
COPY package.json . 

RUN npm install

ENV CORS_ORIGIN http://localhost:3000

EXPOSE 5000

COPY . . 

CMD ["npm", "start"]
