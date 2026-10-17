import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
 
t, times = [], []
with open("task3_t_data.txt") as f:
    for line in f:
        p = line.split()
        if len(p) < 2: continue
        t.append(int(p[0])); times.append(float(p[1]))
 
plt.figure()
plt.plot(t, times, marker="o")
plt.xlabel("Number of threads (t)")
plt.ylabel("Time (ms)")
plt.title("Parallel msort, n = 10^6")
plt.xticks(range(1, 21))
plt.grid(True, ls="--", linewidth=0.5)
plt.tight_layout()
plt.savefig("task3_t.pdf")
print("Saved task3_t.pdf")