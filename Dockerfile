FROM openjdk:11 as base
WORKDIR /app
COPY . .
RUN chmod +x gradlew
RUN ./gradlew build 

FROM tomcat:9
WORKDIR /webapps
COPY --from=base /app/build/lib/sampleweb-0.0.1-SNAPSHOT.war .
RUN rm -rf ROOT && sampleweb-0.0.1-SNAPSHOT.war ROOT.war