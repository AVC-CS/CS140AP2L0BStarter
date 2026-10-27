# AP2L0B tests (git-asmt-repo L2 mips-mars). data/run.sh runs each example program in MARS on
# its own data sets: data/<prog>_dataN.txt -> result_<prog>_N.txt (the program's output, then the
# Mem[...] lines).
#   T1 — ex4.asm (do-while sum)   T2 — ex5.asm (while A[i] <= k)   T3 — ex6.asm (for sum)
#   On every data set of that program: it PRINTS the result, and the result variable holds it
#   in memory after the run (ex4 sum, ex5 i, ex6 sum).
#   Each group also checks that its program uses no blt / bgt / ble / bge pseudo-instruction.
import pytest
import re

DATA = 0x10010000

# program -> (address of the result, {data set: (input, expected result)})
PROGS = {
    'ex4': (DATA + 32, {1: ('N = 1', 5), 2: ('N = 3', 11), 3: ('N = 6', 30)}),
    'ex5': (DATA + 28, {1: ('k = 5', 0), 2: ('k = 25', 2), 3: ('k = 30', 3), 4: ('k = 59', 5)}),
    'ex6': (DATA + 44, {1: ('N = 0', 0), 2: ('N = 1', 4), 3: ('N = 4', 20), 4: ('N = 10', 39)}),
}


def num_re(v):
    """The integer v as a whole number: 30 does not match inside -30 or 300."""
    return r'(?<![\d-])%s(?!\d)' % re.escape(str(v))


def values_in_order(expected, out):
    """Each value appears in the output, in this order (labels and newlines around it are fine)."""
    text = '\n'.join(out)
    pos = 0
    for v in expected:
        m = re.compile(num_re(v)).search(text, pos)
        assert m, f'Expected to see {v} in the output (in this order: {expected}); got {out}'
        pos = m.end()


def result(prog, n):
    """(output_lines, memory) of result_<prog>_N.txt; `memory` maps a word address to its value."""
    out, mem = [], {}
    with open(f'result_{prog}_{n}.txt', 'r') as f:
        for line in f:
            m = re.search(r'Mem\[(0x[0-9a-fA-F]+)\]((?:\s+0x[0-9a-fA-F]{8})+)', line)
            if m:
                addr = int(m.group(1), 16)
                for k, w in enumerate(m.group(2).split()):
                    mem[addr + 4 * k] = int(w, 16)
            else:
                out.append(line.strip())
    return out, mem


def word(mem, addr, signed=True):
    """The word at `addr`, as a signed int."""
    assert addr in mem, f'{addr:#010x} is not in the memory lines - did the program run?'
    w = mem[addr]
    return w - (1 << 32) if signed and w & 0x80000000 else w


def no_pseudo_branch(path):
    """No blt / bgt / ble / bge (or their u forms) outside comments. bltz, blez, bgez, bgtz are
    real instructions and are allowed."""
    bad = []
    for k, line in enumerate(open(path, encoding='utf-8', errors='replace'), 1):
        code = line.split('#', 1)[0]
        if re.search(r'\b(blt|bgt|ble|bge)u?\b', code):
            bad.append(f'line {k}: {line.strip()}')
    assert not bad, (f'{path}: blt / bgt / ble / bge are pseudo-instructions, not allowed here - '
                     'use slt / slti with beq / bne:\n  ' + '\n  '.join(bad))


def check_prog(prog):
    addr, cases = PROGS[prog]
    for n, (inp, want) in cases.items():
        out, mem = result(prog, n)
        print(f'{prog}.asm, data/{prog}_data{n}.txt: {inp} -> expected {want}')
        values_in_order([want], out)
        got = word(mem, addr)
        assert got == want, f'{prog}: the result ({addr:#010x}) should be {want} after the run, but holds {got}'
    no_pseudo_branch(f'{prog}.asm')


@pytest.mark.T1
def test_t1():
    check_prog('ex4')


@pytest.mark.T2
def test_t2():
    check_prog('ex5')


@pytest.mark.T3
def test_t3():
    check_prog('ex6')
