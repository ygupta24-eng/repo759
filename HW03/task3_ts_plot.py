import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
 
ts, times = [], []
with open("task3_ts_data.txt") as f:
    for line in f:
        p = line.split()
        if len(p) < 2: continue
        ts.append(int(p[0])); times.append(float(p[1]))
 
plt.figure()
plt.plot(ts, times, marker="o")
plt.xscale("log", base=2)
plt.xlabel("Threshold (ts)")
plt.ylabel("Time (ms)")
plt.title("Parallel msort, n = 10^6, t = 8")
plt.grid(True, ls="--", linewidth=0.5)
plt.tight_layout()
plt.savefig("task3_ts.pdf")
best = ts[times.index(min(times))]
print("Saved task3_ts.pdf, best ts =", best)