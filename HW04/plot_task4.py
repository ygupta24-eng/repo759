import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

data = {"static": ([], []), "dynamic": ([], []), "guided": ([], [])}

with open("task4_data.txt", "r") as f:
    for line in f:
        parts = line.split()
        if len(parts) < 3:
            continue
        sched, t, ms = parts[0], int(parts[1]), float(parts[2])
        data[sched][0].append(t)
        data[sched][1].append(ms)

fig, axes = plt.subplots(1, 3, figsize=(13, 4), sharey=True)
for ax, sched in zip(axes, ["static", "dynamic", "guided"]):
    ts, ms = data[sched]
    ax.plot(ts, ms, marker="o")
    ax.set_title(f"schedule({sched})")
    ax.set_xlabel("Number of threads")
    ax.set_xticks(range(1, 9))
    ax.grid(True, ls="--", linewidth=0.5)
axes[0].set_ylabel("Time (ms)")
fig.suptitle("N-body simulation time vs. threads (N = 500, end time = 100)")
fig.tight_layout()
fig.savefig("task4.pdf")
print("Saved task4.pdf")