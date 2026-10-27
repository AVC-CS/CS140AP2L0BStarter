# AP2L0B — Examples 4 to 6 (loops)

Three separate programs, each with its own C++ program in its header: `ex4.asm` (do-while), `ex5.asm` (while), `ex6.asm` (for).
Write each one in its own file. Keep every `.data` block as it is, and do not use the
pseudo-instructions `blt`, `bgt`, `ble`, `bge` (use `slt` / `slti` with `beq` / `bne`).
Full instructions are on Canvas.

## Trace it step by step (SPIM)
Open a program (for example `ex4.asm`) in JsSpim (https://shawnzhong.com/JsSpim/) or run `spim` — see the SPIM guide on Canvas.

## Assemble (read any errors it prints)
```
java -jar Mars4_5.jar nc a ex4.asm
```

## Run (type the input, or feed a data file)
```
java -jar Mars4_5.jar nc sm ex4.asm < data/ex4_data1.txt
```

## Check memory after the run
```
java -jar Mars4_5.jar nc sm 0x10010000-0x1001003c ex4.asm < data/ex4_data1.txt
```

## Test (the same checks the autograder runs)
```
data/run.sh
pytest -rP -m T1
pytest -rP -m T2
pytest -rP -m T3
```
`data/run.sh` runs every program on its own data sets (`data/<program>_dataN.txt`) and writes
`result_<program>_N.txt`; T1, T2 and T3 test the three programs in order.

Submit by committing and pushing; the green check on GitHub means the autograder passed.
