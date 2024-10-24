FROM openjdk:17-jdk-alpine as base

# Configure the build environment
FROM base as build

# Install wget and other dependencies
RUN apk add --no-cache maven
RUN apk add tesseract-ocr@4.5.4

WORKDIR /src

# Cache and copy dependencies
ADD pom.xml .
RUN mvn dependency:go-offline dependency:copy-dependencies

# Compile the function
ADD . .
RUN mvn package -DskipTests

# Copy the function artifact and dependencies onto a clean base
FROM base
WORKDIR /function

COPY --from=build /src/target/dependency/*.jar ./
COPY --from=build /src/target/*.jar ./

# Set runtime interface client as default command for the container runtime
ENTRYPOINT [ "java", "-cp", "./*", "com.amazonaws.services.lambda.runtime.api.client.AWSLambda" ]
# Pass the name of the function handler as an argument to the runtime
CMD [ "br.com.consultdg.basic_api.StreamLambdaHandler::handleRequest" ]