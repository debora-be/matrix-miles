# MatrixMiles: Advanced Navigation for Martian Vehicles

## Overview

MatrixMiles provides a reliable navigation simulation platform, meticulously designed for vehicles navigating the Martian terrain. 

## Features

* **Matrix Navigation**: Navigate Mars with precision, following a clear matrix-based system.
* **Boundary Enforcement**: Our system ensures vehicles remain within the set terrain, preventing potential mishaps.
* **Language Support**: MatrixMiles is adaptable to both English and Portuguese navigation commands.
* **Docker Integration**: Utilize our dockerized environment for smooth deployment and running of the application.
* **Auto-Startup**: The application initializes automatically upon the start of the Docker container.

## Setup and Running

### Prerequisites

Ensure you have:

- Docker
- Docker Compose

### Steps to Run

1. **Clone and navigate to repository**:

   ```bash
   git clone git@github.com:debora-be/matrix-miles.git
   cd matrix_miles
   ```

2. **Build using Docker**:

   ```bash
   docker compose build
   ```

3. **Run the application**:

   ```bash
   docker compose run --rm matrix_miles
   ```

Upon startup, simply follow the on-screen instructions to input vehicle positions and navigate the Mars terrain.

## Running the vehicles on Mars

Once the system is up:

1. Define the terrain area (for example, `5 5`).
2. Specify the number of vehicles.
3. For each vehicle, provide its initial position (for example, `1 2 N`) and navigation instructions (for example, `EMEMEMEMM`).

MatrixMiles will then compute and display the final positions of the vehicles based on your commands.

Expected output:

```bash
1 3 N
```

## Testing

To run tests within the Docker environment, use:

```bash
docker compose run --rm matrix_miles mix test
```

Details on testing coverage can be found by running:

```bash
docker compose run --rm matrix_miles mix coveralls
```

This ensures that the navigation protocols are functioning as expected, safeguarding against potential navigation errors.