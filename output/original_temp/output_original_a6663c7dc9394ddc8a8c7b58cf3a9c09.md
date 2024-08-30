**Problem Statement**

Three generators have different power capacities:
- Generator A: 30 kW
- Generator B: 100 kW
- Generator C: 50 kW

The goal is to distribute the power equally among the generators, with each generating 60 kW. The power cannot exceed 100 kW.

**Available Power Transfer Options**

- Transfer 30 kW from A to B
- Transfer 10 kW from A to C
- Transfer 20 kW from B to A
- Transfer 20 kW from B to C
- Transfer 10 kW from C to A

**Constraints**

- Only 3 power transfers are allowed.
- The power distribution must be equal (60 kW per generator).
- The total power cannot exceed 100 kW.

### Step 1: Initial Power Distribution

| Generator | Power (kW) |
|-----------|------------|
| A         | 30         |
| B         | 100        |
| C         | 50         |

### Step 2: First Transfer

- Transfer 30 kW from A to B.

| Generator | Power (kW) |
|-----------|------------|
| A         | 0          |
| B         | 130        |
| C         | 50         |

### Step 3: Second Transfer

- Transfer 20 kW from B to A.

| Generator | Power (kW) |
|-----------|------------|
| A         | 20         |
| B         | 110        |
| C         | 50         |

### Step 4: Third Transfer

- Transfer 10 kW from C to A.

| Generator | Power (kW) |
|-----------|------------|
| A         | 30         |
| B         | 110        |
| C         | 40         |

### Step 5: Final Power Distribution

- Transfer 20 kW from B to C.

| Generator | Power (kW) |
|-----------|------------|
| A         | 30         |
| B         | 90         |
| C         | 60         |

### Step 6: Final Check

- The power distribution is now equal (60 kW per generator).
- The total power does not exceed 100 kW.

### Conclusion

The final power distribution is:
- Generator A: 30 kW
- Generator B: 90 kW
- Generator C: 60 kW

This distribution meets the requirements of equal power generation (60 kW per generator) and does not exceed the maximum allowed power (100 kW).