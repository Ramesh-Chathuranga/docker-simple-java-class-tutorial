# Java Hello World — Docker Guide

Simple Java Hello World app packaged with Docker and Docker Compose.

## Project files

| File | Purpose |
|------|---------|
| `HelloWorld.java` | Hello World Java source |
| `Dockerfile` | Builds and runs the Java app |
| `docker-compose.yml` | Runs the app with Docker Compose |

---

## 1. Build the Docker image

From the project directory:

```bash
docker build -t java-hello-world:latest .
```

- `-t java-hello-world:latest` — tags (names) the image
- `.` — build context (current folder with the Dockerfile)

---

## 2. Run the Docker image / create a container

Running an image creates and starts a **container**:

```bash
docker run java-hello-world:latest
```

Expected output:

```text
Hello, World!
```

### Useful `docker run` options

```bash
# Run and remove the container when it exits
docker run --rm java-hello-world:latest

# Run in the background (detached)
docker run -d java-hello-world:latest
```

### List containers

```bash
docker ps          # running containers
docker ps -a       # all containers (including stopped)
```

---

## 3. Add a name to a Docker container (terminal)

Use `--name` when you create/run the container:

```bash
docker run --name my-hello-java java-hello-world:latest
```

- `--name my-hello-java` — sets the container name to `my-hello-java`

### Rename an existing container

```bash
docker rename my-hello-java hello-app
```

### Manage a named container

```bash
docker start my-hello-java    # start a stopped container
docker stop my-hello-java     # stop a running container
docker logs my-hello-java     # view container output
docker rm my-hello-java       # remove the container
```

---

## 4. Push the image to Docker Hub

Docker Hub repository: [rameshchathurangarathnayaka/sample_java_ncc_repo](https://hub.docker.com/r/rameshchathurangarathnayaka/sample_java_ncc_repo)

### Step 1 — Log in to Docker Hub

```bash
docker login
```

Enter your Docker Hub username (`rameshchathurangarathnayaka`) and password (or access token).

### Step 2 — Tag the image for your repository

```bash
docker tag java-hello-world:latest rameshchathurangarathnayaka/sample_java_ncc_repo:latest
```

### Step 3 — Push the image

```bash
docker push rameshchathurangarathnayaka/sample_java_ncc_repo:latest
```

After a successful push, the image is available at:

`https://hub.docker.com/r/rameshchathurangarathnayaka/sample_java_ncc_repo`

### Pull and run from Docker Hub (anyone)

```bash
docker pull rameshchathurangarathnayaka/sample_java_ncc_repo:latest
docker run --name hello-from-hub rameshchathurangarathnayaka/sample_java_ncc_repo:latest
```

---

## 5. Use the Docker Hub image with docker-compose.yml

After the image is pushed to Docker Hub, Compose can pull and run it **without building locally**.

Your `docker-compose.yml` uses:

```yaml
services:
  hello-world:
    image: rameshchathurangarathnayaka/sample_java_ncc_repo:latest
    container_name: java-hello-world
    pull_policy: always
```

- `image:` — Docker Hub image to use
- `container_name:` — name of the running container
- `pull_policy: always` — always pull the latest image from Docker Hub before starting

### Run with Compose (pulls from Docker Hub)

```bash
docker compose pull
docker compose up
```

Or in one step:

```bash
docker compose up --pull always
```

Expected output:

```text
Hello, World!
```

### Other Compose commands

```bash
docker compose up -d           # run in background
docker compose logs            # view logs
docker compose down            # stop and remove the container
docker compose pull            # update image from Docker Hub
```

### Optional: build locally, then push, then run from Hub

```bash
# 1) Build locally
docker build -t rameshchathurangarathnayaka/sample_java_ncc_repo:latest .

# 2) Push to Docker Hub
docker push rameshchathurangarathnayaka/sample_java_ncc_repo:latest

# 3) Run via Compose (uses the Hub image)
docker compose up
```

# END --