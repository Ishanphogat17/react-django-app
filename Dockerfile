FROM node:14

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY requirements.txt ./

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 3000 5000

CMD ["sh", "-c", "python3 app.py & node app.js"]
