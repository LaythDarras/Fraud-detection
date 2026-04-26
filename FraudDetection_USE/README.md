# FraudDetection USE OCL Project
## Generated from StarUML profile: profileUml__1_.mdj

---

## 📁 Folder Structure

```
FraudDetection_USE/
├── model/
│   └── FraudDetection.use     ← UML classes + OCL constraints
├── soil/
│   └── instances.soil         ← Object instances + test data
├── diagrams/
│   └── class_diagram.md       ← UML class diagram (reference)
├── icons/
│   └── (USE tool icons)
└── README.md                  ← This file
```

---

## ⚙️ Prerequisites

1. **Java 11+** must be installed
   - Check: `java -version`
   - Download: https://adoptium.net/

2. **USE Tool** must be downloaded
   - Download: https://sourceforge.net/projects/useocl/
   - Extract the zip anywhere (e.g. `C:\USE\` on Windows)

---

## 🚀 How to Run — GUI Mode (Recommended)

### Windows
```bat
cd C:\USE\bin
use.bat -gui
```

### Linux / Mac
```bash
cd ~/use/bin
./use -gui
```

### Then inside USE GUI:
1. `File` → `Open Specification...` → select `model/FraudDetection.use`
2. `File` → `Open State...` → select `soil/instances.soil`
3. Click the **"Check"** button (✓) to validate all invariants
4. Open `View` → `Class Diagram` to see the UML diagram
5. Open `View` → `Object Diagram` to see the instances

---

## 🚀 How to Run — Command Line Mode

```bash
# Load model and instances, check constraints, then exit
java -jar use.jar -nogui model/FraudDetection.use soil/instances.soil
```

Or interactively:
```bash
java -jar use.jar model/FraudDetection.use
# Then type inside USE shell:
USE> open soil/instances.soil
USE> check
USE> check -v    -- verbose: shows each invariant result
```

---

## ✅ OCL Constraints Summary

| Class            | Constraint              | Description                                      |
|------------------|-------------------------|--------------------------------------------------|
| Customer         | ValidRiskScore          | riskScore ∈ [0.0, 1.0]                          |
| Transaction      | PositiveAmount          | amount > 0                                       |
| Transaction      | ValidFraudScore         | fraudScore ∈ [0.0, 1.0]                         |
| Transaction      | SuspiciousHasAlert      | isSuspicious → preprocessing exists             |
| Preprocessing    | FeaturesNotEmpty        | features ≠ ''                                   |
| FraudModel       | ValidThreshold          | threshold ∈ [0.0, 1.0]                          |
| FraudModel       | ValidAccuracy           | accuracy ∈ [0.0, 1.0]                           |
| FraudModel::predict | TransactionNotNull   | precondition: t must be a Transaction           |
| FraudModel::predict | ValidPrediction      | postcondition: result ∈ [0.0, 1.0]             |
| SupervisedModel  | MinimumAccuracy         | accuracy ≥ 0.85                                 |
| SupervisedModel  | AlgorithmDefined        | algorithm ≠ ''                                  |
| UnsupervisedModel| ValidContamination      | contamination ∈ [0.0, 0.5]                      |
| UnsupervisedModel| ValidAnomalyThreshold   | anomalyThreshold ∈ [0.0, 1.0]                  |
| QualityOfService | AcceptableLatency       | latency ≤ 100ms                                 |
| QualityOfService | F1ScoreFormula          | f1Score = 2*(p*r)/(p+r)                         |
| Alert            | MinimumConfidence       | confidence ≥ 0.5                                |
| Alert            | ValidConfidence         | confidence ∈ [0.0, 1.0]                         |
| Alert            | AlertIdNotEmpty         | alertId ≠ ''                                    |

---

## 🔍 Useful USE Shell Commands

```
check            -- check all invariants on current state
check -v         -- verbose invariant check
check -d         -- show only failed invariants
?<ocl-expr>      -- evaluate any OCL expression
info class       -- list all classes
info model       -- show model summary
help             -- show all commands
```

---

## 📊 Example OCL Queries to Try

```ocl
-- High-risk customers
?Customer.allInstances()->select(c | c.riskScore > 0.7)

-- Suspicious transactions
?Transaction.allInstances()->select(t | t.isSuspicious = true)

-- Average fraud score
?Transaction.allInstances()->collect(t | t.fraudScore)->sum()

-- Models above 90% accuracy
?FraudModel.allInstances()->select(m | m.accuracy >= 0.90)
```

---

## ⚠️ Notes

- `FraudModel` is the parent class; `SupervisedModel`, `UnsupervisedModel`,
  and `OnlineLearning` extend it (inheritance with `<` in USE syntax).
- USE does not support `DateTime` natively — `timestamp` is modeled as `String`.
- The `contamination` field was typed as `String` in StarUML but is `Real` here
  for proper OCL numeric comparison.
