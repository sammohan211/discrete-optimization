# Workshop 0 — First MiniZinc models

Introductory exercises covering decision variables, constraints, satisfaction
vs. optimization, parameters, and arrays.

## Files

| File | What it shows |
|------|---------------|
| `hello.mzn` | Minimal `output` statement — "Hello World!" |
| `x110.mzn` | Single decision variable `var 1..10: x` solved with `solve satisfy` |
| `xopt.mzn` | Optimization: minimize `(x-7)^2` subject to `x mod 4 = 0` |
| `io.mzn` | Reading an integer parameter `n` from a `.dzn` data file |
| `array.mzn` | Array of decision variables; constraint that `sum(x) = product(x)` |
| `seq.mzn` | Sequence with adjacency and divisibility constraints; maximize sum |
| `workshop_0.pdf` | Course handout |

## Running

```bash
minizinc --solver gecode workshop_0/xopt.mzn
```

For models that need data (e.g. `io.mzn`, `array.mzn`, `seq.mzn`), pass `-D`:

```bash
minizinc --solver gecode workshop_0/array.mzn -D "n=5;"
```
