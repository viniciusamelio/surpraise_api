FROM dart:stable AS build

WORKDIR /app
COPY pubspec.* ./
RUN dart pub upgrade
RUN dart pub get

COPY . .

RUN dart pub get --offline
RUN dart compile kernel bin/main.dart -o bin/main

Expose 8080
CMD ["dart", "run", "bin/main", "--dart-define mongo_url'=${{shared.mongo_url}}'"]