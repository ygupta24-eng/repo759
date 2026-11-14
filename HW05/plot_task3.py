import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

ns, t512, t16 = [], [], []
with open("task3_data.txt") as f:
    for line in f:
        p = line.split()
        if len(p) < 3:
            continue
        ns.append(int(p[0])); t512.append(float(p[1])); t16.append(float(p[2]))

plt.figure()
plt.plot(ns, t512, marker="o", label="512 threads per block")
plt.plot(ns, t16, marker="s", label="16 threads per block")
plt.xscale("log", base=2)
plt.yscale("log")
plt.xlabel("n")
plt.ylabel("Kernel time (ms)")
plt.title("vscale kernel time vs. n")
plt.legend()
plt.grid(True, ls="--", linewidth=0.5)
plt.tight_layout()
plt.savefig("task3.pdf")
print("Saved task3.pdf")