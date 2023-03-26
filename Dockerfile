FROM --platform=arm64 gradle:8.0.2-jdk17 AS TEMP_BUILD_IMAGE
WORKDIR /home/gradle/src/

COPY --chown=gradle:gradle . /home/gradle/src
USER root
RUN chown -R gradle /home/gradle/src

COPY . .
RUN gradle clean bootJar


FROM --platform=arm64 openjdk:17
COPY --from=TEMP_BUILD_IMAGE $APP_HOME/build/libs/ROOT.jar  /application/ROOT.jar

WORKDIR /application

# ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/application/ROOT.jar"]
# ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/application/ROOT.jar"]
