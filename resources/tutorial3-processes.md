# Generic process

```mermaid
flowchart TD
    A[Generate temporary data contract] 
    A --> G[Compare with original data contract]
    G --> K[Impact analysis &<br/>Suggested version]
    K --> O[Deploy/Reverse/Act]

    style A fill:#F33126
    style G fill:#38992A
    style K fill:#0096FF
    style O fill:#8134BE  
```

# Minor change: Adding a field

```mermaid
flowchart TD
    A[Generate temporary data contract] 
    A --> G[Compare with contract v0.1.0]
    G --> K[Impact analysis: 0 major, 8 minor, 0 major, 0 patch &<br/>Suggested version: v0.2.0]
    K --> O[Deploy automatically]

    style A fill:#F33126
    style G fill:#38992A
    style K fill:#0096FF
    style O fill:#8134BE  
```

# Minor change: Deleting a field

```mermaid
flowchart TD
    A[Generate temporary data contract]
    A --> G[Compare with contract v0.2.0]
    G --> K[Impact analysis: 1 major, 0 minor, 0 patch &<br/>Suggested version: v1.0.0]
    K --> O[Deploy automatically]

    style A fill:#F33126
    style G fill:#38992A
    style K fill:#0096FF
    style O fill:#8134BE  
```

# Sponsor
If you like this project, I would be super grateful if you could help me finance it through [my Buy me a Coffee page](https://buymeacoffee.com/jgperrin) (although I mostly drink tea...)
