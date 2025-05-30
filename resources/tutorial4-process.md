# Data contract enhancement process

```mermaid
---
config:
  layout: dagre
---
flowchart LR
    n1["Relational
    Database"] --> n2["Data 
    Contract"]
    n2 --> n3["Pretty PDF for 
    your users"]
    n3 --> n4["User Feedback"]
    n4 -- Yes --> n2
    n1@{ shape: cyl}
    n2@{ shape: doc}
    n3@{ shape: doc}
    n4@{ shape: decision}
    style n1 fill:#F33126
    style n2 fill:#38992A
    style n3 fill:#0096FF
    style n4 fill:#8134BE  
    ```