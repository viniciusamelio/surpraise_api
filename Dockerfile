FROM dart:stable AS build
ARG mongo_url

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .

RUN dart pub get --offline
RUN dart compile kernel bin/main.dart -o bin/main

Expose 8080
CMD ["dart", "run", "--define=$mongo_url", "bin/main.dart"]