# Discrete Optimization

Personal workspace for learning discrete optimization with MiniZinc.

## Setup

MiniZinc bundle (IDE + Gecode, Chuffed, OR-Tools, HiGHS solvers) is installed at
`~/opt/MiniZincIDE-2.9.7-bundle-linux-x86_64/` and on `PATH`.

Python tooling is managed with [uv](https://docs.astral.sh/uv/):

```bash
uv sync           # create .venv and install dependencies
uv run python ... # run inside the project venv
```

## Running models

From the command line:

```bash
minizinc --solver gecode model.mzn data.dzn
```

From Python (via the `minizinc` package):

```python
from minizinc import Instance, Model, Solver
model = Model("model.mzn")
gecode = Solver.lookup("gecode")
inst = Instance(gecode, model)
print(inst.solve())
```

Or launch the IDE: `MiniZincIDE`.

## Layout

- `examples/` — small standalone snippets.
- `workshops/` — exercises from the MiniZinc course; see [`workshops/README.md`](workshops/README.md).

## License

[MIT](LICENSE)
