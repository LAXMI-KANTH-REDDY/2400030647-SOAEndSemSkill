# Dockerized Spring Boot Microservice

A small Spring Boot REST microservice intended for import into Spring Tools for Eclipse (STS).

## Endpoint

- Method: `GET`
- URL: `http://localhost:8000/api/data`
- Response body: `Succesfully responded to the microservice `

## Requirements

- JDK 17
- Spring Tools 4 for Eclipse (or Eclipse with Spring Tools)
- Docker Desktop / Docker Engine
- Internet access on the first Maven/Docker build to download dependencies and base images

## Import into Spring Tools

1. Extract the ZIP file.
2. Open Spring Tools for Eclipse.
3. Select **File > Import**.
4. Choose **Maven > Existing Maven Projects**, then click **Next**.
5. Browse to the extracted `microservice-docker-springtools` folder.
6. Ensure `pom.xml` is selected, then click **Finish**.
7. Wait for Maven dependencies to download.
8. Open `AppServiceApplication.java`, right-click it, and choose **Run As > Spring Boot App**.
9. Visit `http://localhost:8000/api/data` in a browser. Stop the app in STS before starting the Docker container, otherwise port 8000 may already be occupied.

## Build and run with Docker

Open a terminal in the project root (the folder containing `Dockerfile`).

### 1. Build the image

```bash
docker build -t app-service:v1 .
```

The final dot is important: it tells Docker to use the current folder as the build context.

### 2. Run the container

```bash
docker run --name app-service-container -p 8000:8000 app-service:v1
```

Keep this terminal open while testing. To run it in the background instead:

```bash
docker run -d --name app-service-container -p 8000:8000 app-service:v1
```

### 3. Verify the endpoint

Open this URL:

http://localhost:8000/api/data

Expected response:

```text
Succesfully responded to the microservice 
```

You can also test from another terminal:

```bash
curl http://localhost:8000/api/data
```

### 4. Stop and remove the container

If running in the foreground, press `Ctrl+C`.

If running in detached mode:

```bash
docker stop app-service-container
docker rm app-service-container
```

## Useful Docker commands

```bash
docker images
docker ps
docker ps -a
docker logs app-service-container
```

## Troubleshooting

- **Port is already allocated:** Stop the Spring Boot app in STS or another process using port 8000. Alternatively map a different host port, for example `-p 8001:8000`, and open `http://localhost:8001/api/data`.
- **Docker daemon is not running:** Start Docker Desktop and wait until its engine is running.
- **Maven build fails:** Confirm JDK 17 is installed and that the machine has internet access. In STS, right-click the project and select **Maven > Update Project**.
- **Container exits immediately:** Run `docker ps -a` and inspect the logs with `docker logs app-service-container`.

## Project structure

```text
microservice-docker-springtools/
├── Dockerfile
├── .dockerignore
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/com/example/appservice/
        │   ├── AppServiceApplication.java
        │   └── controller/DataController.java
        └── resources/application.properties
```
