# Robot Framework + Selenium + Python

## Features

- Robot Framework
- Selenium
- Python
- Page Object Model
- Data Driven Testing
- Parallel Execution
- Screenshot on Failure
- Logging
- Multi Browser Support
- CI/CD Ready

## Installation

```bash
pip install -r requirements.txt
```

Run Tests

```powershell
powershell -ExecutionPolicy Bypass -File .\run_tests.ps1
```

Run Smoke Suite

```powershell
powershell -ExecutionPolicy Bypass -File .\run_tests.ps1 tests/smoke
```

```bash
robot tests/smoke
```

Run in Parallel

```bash
pabot tests
```