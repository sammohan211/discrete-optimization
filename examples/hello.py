"""Same hello.mzn model, driven from Python via the minizinc package."""
from minizinc import Instance, Model, Solver

model = Model("examples/hello.mzn")
gecode = Solver.lookup("gecode")
inst = Instance(gecode, model)
result = inst.solve()
print(f"x = {result['x']}")
