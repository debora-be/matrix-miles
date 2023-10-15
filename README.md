Certainly! Here's a README for your project:

---

# MatrixMiles

## Overview

MatrixMiles is a navigation simulation project designed to handle the navigation of vehicles on the Martian terrain. Given an initial position and a series of movements, the application calculates and displays the final position of each vehicle on the matrix.

The vehicles move according to cardinal directions (N, S, E, W) or their Portuguese equivalents (N, S, L, O). The movement logic takes into account boundary constraints, ensuring vehicles don't go beyond the provided matrix size.

## Features
- Simulation of multiple vehicles' movements on a specified matrix.
- Boundary constraints to ensure vehicles remain within the matrix.
- Support for both English and Portuguese cardinal directions.
- Dockerized setup for easy environment management.

## Building and Running

### Prerequisites:
Ensure you have [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed on your system.

### Steps:
1. Clone the repository:

   ```bash
   git clone [repository_url] matrix_miles
   cd matrix_miles
   ```

2. Build the Docker environment:

   ```bash
   docker-compose build
   ```

3. Run the Docker container:

   ```bash
   docker-compose run --rm matrix_miles ash
   ```

Once inside the container, you can interact with the system using the Elixir REPL (`iex`) and run the program with the appropriate commands.

## Testing

Inside the Docker container, run:

```bash
mix test
```

This will execute all test cases and provide an output of the results.

## Usage

Inside the Docker container, and after starting the `iex` session with `iex -S mix`, you can navigate vehicles as follows:

```elixir
MatrixMiles.call({5, 5}, 
  [
    {%Vehicle{x: 1, y: 2, direction: "N"}, "EMEMEMEMM"},
    {%Vehicle{x: 3, y: 3, direction: "L"}, "MMDMMDMDDM"}
  ]
)
```

This will output the final positions of the vehicles after executing the movements.

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss the changes you'd like to make.
