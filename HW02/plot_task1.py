import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import re

n_values = []
times_ms = []

# Each line looks like: "<n> Time taken for inclusive scan of <n> elements: <time> ms"
# We only need the first number (n) and the last number before "ms" (time_ms).
float_pattern = re.compile(r'[-+]?\d*\.?\d+')

with open("task1_data.txt", "r") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        numbers = float_pattern.findall(line)
        n_values.append(int(numbers[0]))
        times_ms.append(float(numbers[-1]))

plt.figure()
plt.plot(n_values, times_ms, marker='o')
plt.xscale('log', base=2)
plt.xlabel('n (array size, log scale)')
plt.ylabel('Time (ms)')
plt.title('Scan Function Scaling Analysis')
plt.grid(True, which="both", ls="--", linewidth=0.5)
plt.tight_layout()
plt.savefig("task1.pdf")
print("Saved task1.pdf")