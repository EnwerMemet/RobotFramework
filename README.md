# ABN AMRO Mortgage Calculator Test Suite

Robot Framework automation project for testing the ABN AMRO mortgage calculator.

## Website Under Test
https://www.abnamro.nl/en/personal/mortgages/mortgage-calculator/index.html

## Project Structure

```
RobotFramework/
├── PageObjects/
│   └── MortgageCalculatorPage.robot    # Page Object Model - selectors & keywords
├── TestCases/
│   ├── ABN_Mortgage_Calculator.robot  # Test suite (7 tests)
│   ├── Screenshots/                   # Failed test screenshots
│   ├── allure-results/                 # Allure test results
│   └── allure-report/                  # Allure HTML report
├── README.md
└── .gitignore
```

## Test Cases

| # | Test Name | Technique | Description |
|---|-----------|-----------|-------------|
| TC-001 | UI Elements Test | Smoke Testing | Verifies UI element visibility and page load |
| TC-002 | Verify Mortgage Calculation | Functional Validation | Validates mortgage formula output |
| TC-003 | Clear And Recalculate | State Transition | Verifies calculator resets on new input |
| TC-004 | Boundary Values Test | BVA | Tests min (0) and max (999,999) income |
| TC-005 | Different Income Amounts | Data-Driven | Tests income brackets using template |
| TC-006 | Input Validation Tests | Negative Testing | Tests invalid inputs |
| TC-007 | Responsive Design Test | Compatibility | Tests Mobile/Tablet/Desktop |

## Mortgage Formula

The expected calculation uses the Dutch mortgage formula:
```
n = 360 (30 years)
r = (3.56 / 100) / 12  (monthly interest rate)
f = (r * (1 + r)^n) / ((1 + r)^n - 1)
q = 0.231
total = ((income * q / 12) / f) + 27000
max_mortgage = round(total)
monthly_payment = round(total * f)
```

Validation tolerance: 10% for max mortgage, 20% for monthly payment.

## Running Tests

```bash
# Run all tests
python3 -m robot TestCases/ABN_Mortgage_Calculator.robot

# Run with Allure reporting
python3 -m robot --outputdir TestCases/allure-results TestCases/ABN_Mortgage_Calculator.robot
allure serve TestCases/allure-results
```

## Technologies Used
- Robot Framework
- SeleniumLibrary
- Allure Reports
- Page Object Model (POM)
