# Workshops

Hands-on exercises following the MiniZinc course material.

| Workshop | Topic |
|----------|-------|
| [workshop_0](workshop_0/) | First steps: variables, constraints, `solve satisfy` / `minimize`, arrays |
| [workshop_1](workshop_1/) | Working with data files (`.dzn`); modelling temperature dynamics |

## Running a model

```bash
minizinc --solver gecode workshops/workshop_1/temperature.mzn workshops/workshop_1/data/temp0.dzn
```
