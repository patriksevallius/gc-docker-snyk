FROM openjdk:17-jdk AS builder

WORKDIR /app

COPY ./Grasscutter /app

RUN chmod +x ./gradlew
RUN ./gradlew && ./gradlew jar

# runtime container
FROM openjdk:22-ea-14-jdk-slim

WORKDIR /app

EXPOSE 443
EXPOSE 22102/udp

# change name
COPY --from=builder /app/grasscutter-1.1.0.jar /app/grasscutter.jar

# copy reousces
COPY ./Grasscutter_Resources/Resources /app/resources
COPY ./Grasscutter/data /app/data
COPY ./Grasscutter/keys /app/keys
COPY ./Grasscutter/keystore.p12 /app/keystore.p12
COPY ./gc-config/config.json /app/config.json

VOLUME [ "/app" ]