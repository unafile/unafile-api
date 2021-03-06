FROM node:8-slim

RUN apt-get update

# Unoconv
RUN apt-get install -yq \
  unoconv libreoffice-calc libreoffice-impress libreoffice-draw libreoffice-writer

RUN unoconv --listener

# Puppeteer
RUN apt-get install -yq \
  gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
  libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
  libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
  libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
  fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
  ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget

# Cleanup
RUN apt-get clean
RUN apt-get autoremove -y

# Setup project
WORKDIR /unafile
COPY . /unafile

# Install npm dependancies
RUN npm install

# Compile project
RUN npm run build

# Prune npm devDependancies
RUN npm prune --production

# Run project
CMD ["npm", "start"]

# Expose test port
EXPOSE 3000
