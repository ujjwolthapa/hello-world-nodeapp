# hello-world-nodeapp

A simple **Hello World** Node.js HTTP server with a MySQL-connected variant, Docker support, and a full CI/CD pipeline using GitHub Actions and Docker Hub.

---

## Project Structure

```
hello-world-nodeapp/
├── app.js                        # Main Node.js HTTP server
├── Dockerfile                    # Docker image for the main app (nodemon)
├── node-mysql/                   # MySQL-connected Node.js app
│   ├── app.js
│   └── Dockerfile
└── .github/
    └── workflows/
        ├── staging.yml           # CI: builds & pushes on push to staging
        └── production.yml        # CI: builds & pushes on merged PR to main
```

---

## Apps

### Root App

A minimal Node.js HTTP server using the built-in `http` module. Responds with `Hello World from main branch` on all requests.

- Runs on port `3000`
- Uses `nodemon` for hot-reloading inside the container

### `node-mysql`

A Node.js app with MySQL connectivity. Runs as a standard Node process inside Docker.

- Runs on port `3000`
- Dependencies installed via `npm install`

---

## Getting Started

### Prerequisites

- [Node.js 18+](https://nodejs.org/)
- [Docker](https://www.docker.com/)

### Run Locally

```bash
node app.js
```

Visit: `http://localhost:3000`

---

## Docker

### Root App

```bash
# Build
docker build -t hellonodejs .

# Run
docker run -p 3000:3000 hellonodejs
```

### node-mysql App

```bash
# Build
docker build -t mysqlnode ./node-mysql/

# Run
docker run -p 3000:3000 mysqlnode
```

---

## CI/CD — GitHub Actions

This project uses two automated workflows with a **self-hosted runner** and **Docker Hub** for image publishing.

### Required Secrets

| Secret            | Description              |
|-------------------|--------------------------|
| `DOCKER_USERNAME` | Your Docker Hub username |
| `DOCKER_PASSWORD` | Your Docker Hub password |

---

### Staging Workflow (`.github/workflows/staging.yml`)

**Trigger:** Push to the `staging` branch

**Steps:**
1. Checkout code
2. Install Node.js 18
3. Build Docker image → `<DOCKER_USER>/hellonodejs:github`
4. Push image to Docker Hub

```bash
git push origin staging
```

---

### Production Workflow (`.github/workflows/production.yml`)

**Trigger:** Pull request to `main` is **merged**

**Steps:**
1. Checkout code
2. Install Node.js 18
3. Build Docker image from `./node-mysql/` → `<DOCKER_USER>/mysqlnode:latest`
4. Push image to Docker Hub

```bash
# Open a PR targeting main → merge it → pipeline triggers automatically
```

---

## License

This project is open source. See the [LICENSE](LICENSE) file for details.
