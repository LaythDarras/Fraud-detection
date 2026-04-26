# FraudDetection — UML Class Diagram Reference
## (Generated from profileUml__1_.mdj)

```
┌─────────────────────────────────┐
│            Customer              │
├─────────────────────────────────┤
│ + customerId  : String          │
│ + name        : String          │
│ + riskScore   : Real            │◄── inv: [0.0 .. 1.0]
│ + historicalData : String       │
├─────────────────────────────────┤
│ + updateRiskScore()             │
│ + getHistoricalBehavior():String│
└───────────────┬─────────────────┘
                │ 1
                │ effectue
                │ 0..*
┌───────────────▼─────────────────┐
│           Transaction            │
├─────────────────────────────────┤
│ + txId        : String          │
│ + amount      : Real            │◄── inv: > 0
│ + timestamp   : String          │
│ + location    : String          │
│ + category    : String          │
│ + isSuspicious: Boolean         │◄── inv: implies preprocessing
│ + fraudScore  : Real            │◄── inv: [0.0 .. 1.0]
├─────────────────────────────────┤
│ + validateAmount() : Boolean    │
└───────────────┬─────────────────┘
                │ 1
                │ prétraitée par
                │ 0..*
┌───────────────▼─────────────────┐
│          Preprocessing           │
├─────────────────────────────────┤
│ + normalization : Boolean       │
│ + features      : String        │◄── inv: not empty
├─────────────────────────────────┤
│ + cleanData()                   │
│ + normalize()                   │
│ + extractFeatures()             │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│           FraudModel             │
├─────────────────────────────────┤
│ + modelId   : String            │
│ + accuracy  : Real              │◄── inv: [0.0 .. 1.0]
│ + threshold : Real              │◄── inv: [0.0 .. 1.0]
├─────────────────────────────────┤
│ + predict(t:Transaction):Real   │◄── pre: t not null
│ + updateThreshold(v:Real)       │   post: result in [0,1]
└────┬──────────┬─────────┬───────┘
     │          │         │
  extends    extends   extends
     │          │         │
┌────▼───┐ ┌───▼────┐ ┌──▼────────────┐
│Supervis│ │Unsuperv│ │ OnlineLearning │
│edModel │ │isedModel│ ├───────────────┤
├────────┤ ├────────┤ │+batchSize:Int │
│+algo   │ │+contam │ │+updateFreq:Int│
│+trainSet│ │+anoThr │ └───────────────┘
├────────┤ ├────────┤
│+train()│ │+fit()  │
│+eval() │ │+predict│◄── inv: contamination ≤ 0.5
└────────┘ │ Anomaly│
  inv:     └────────┘
  accuracy
  ≥ 0.85

┌─────────────────────────────────┐     ┌──────────────────────────┐
│             Alert                │     │      QualityOfService     │
├─────────────────────────────────┤     ├──────────────────────────┤
│ + alertId   : String            │     │ + precision : Real        │
│ + confidence: Real              │◄──  │ + recall    : Real        │
│ + status    : String            │     │ + f1Score   : Real        │◄── formula
├─────────────────────────────────┤     │ + latency   : Real        │◄── ≤ 100
│ + sendNotification()            │     ├──────────────────────────┤
│ + updateStatus(s:String)        │     │ + computeMetrics()        │
└─────────────────────────────────┘     └──────────────────────────┘
  inv: confidence ≥ 0.5
  inv: alertId ≠ ''
```

## Inheritance

```
FraudModel
├── SupervisedModel    (accuracy ≥ 0.85, algorithm defined)
├── UnsupervisedModel  (contamination ≤ 0.5)
└── OnlineLearning
```

## Associations

| From         | Role         | To               | Multiplicity |
|--------------|--------------|------------------|--------------|
| Customer     | effectue     | Transaction      | 1 → 0..*    |
| Transaction  | prétraitée   | Preprocessing    | 1 → 0..*    |
| FraudModel   | génère       | Alert            | 1 → 0..*    |
| Alert        | évalué par   | QualityOfService | 0..* → 1    |
