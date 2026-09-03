# Smart Contract Fuzzing Tools Evaluation

This repository contains test scenarios and smart contracts (written in Solidity) used to evaluate and compare different *fuzz testing* tools within the Ethereum ecosystem.

The main objective of this environment is to measure the effectiveness of vulnerability detection, execution cost analysis (gas), and the overall usability of the different tools through practical use cases.

## Project Structure

The repository is organized into different environments, each configured for a specific testing tool:

- **`pruebas-medusa/`**: Contains the full test suite and configuration adapted to be evaluated with **Medusa**, the next-generation *fuzzer* developed by Trail of Bits. This section leverages the tool's concurrent architecture and its *Mutation-Based Fuzzing* engine to detect logical errors and attacks such as reentrancy. Its internal structure includes:
  - `contracts/`: Source code of the smart contracts under test (e.g., `CounterGas.sol`, `VulnerableBank.sol`).
  - `medusa/`: Specific testing contracts that define the assertions and properties evaluated.
  - Configuration files (`medusa.json`, `medusa_gas.json`, `medusa_reentrancy.json`): Centralized profiles to run different types of campaigns.
- **`pruebas-foundry/`**: Environment configured to run tests using the **Foundry** ecosystem (via `forge test` and `forge fuzz`).
- **`pruebas-echidna/`**: Environment prepared for **Echidna**, configured to perform *property-based testing*.

## Running Tests with Medusa

To execute the tests included in the `pruebas-medusa` folder, ensure you have previously installed [Medusa](https://github.com/crytic/medusa) and the necessary compilation tools (such as `crytic-compile`).

1. Access the working directory:
   ```bash
   cd pruebas-medusa
   ```
2. Launch the fuzzing campaign. The behavior will be dictated by the centralized parameters in the `medusa.json` file:
   ```bash
   medusa fuzz
   ```
