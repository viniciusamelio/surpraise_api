FROM dart:stable AS build

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .

RUN dart pub get --offline
RUN dart compile kernel bin/main.dart -o bin/main

Expose 8080
CMD ["dart", "run", "--define=mongo_url=mongodb://mongo:LtIliGWT6zDBv8XyC568@containers-us-west-150.railway.app:7595", "bin/main.dart"]