FROM maven:3-jdk-11 as mvnbuild

ADD ./src /opt/ObservationReplayer/src
ADD ./pom.xml /opt/ObservationReplayer/
WORKDIR /opt/ObservationReplayer

RUN mvn clean install

FROM openjdk:11-jre-slim

WORKDIR /opt/app

COPY --from=mvnbuild /opt/ObservationReplayer/target/ObservationReplayer-1.0-SNAPSHOT-jar-with-dependencies.jar /opt/app/

CMD ["java","-jar", "ObservationReplayer-1.0-SNAPSHOT-jar-with-dependencies.jar"]