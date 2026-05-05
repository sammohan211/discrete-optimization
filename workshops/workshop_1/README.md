# Workshop 1 — Data files and temperature modelling

Working with separate model (`.mzn`) and data (`.dzn`) files. The model
simulates an hourly temperature trajectory driven by external `readings` and a
`start` temperature.

## Files

| File | What it is |
|------|------------|
| `temperature.mzn` | Base model: temperature evolves as `temp[h] = (temp[h-1] + readings[h]) div 2` |
| `temperature_nd.mzn` | Variant introducing a `CHOICE` enum for control actions (heat / cool / nothing) |
| `temperature.mzc` / `temperature_nd.mzc` | MiniZinc checker models |
| `workshop_1.mzp` | MiniZinc IDE project file |
| `data/temp0.dzn` … `temp4.dzn` | Sample datasets |
| `temperature.pdf` | Course handout |

## Running

```bash
minizinc --solver gecode workshop_1/temperature.mzn workshop_1/data/temp0.dzn
```
