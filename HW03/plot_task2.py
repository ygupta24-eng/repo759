import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
 
threads = []
times_ms = []
 
with open("task2_data.txt", "r") as f:
    for line in f:
        parts = line.split()
        if len(parts) < 2:
            continue
        threads.append(int(parts[0]))
        times_ms.append(float(parts[1]))
 
plt.figure()
plt.plot(threads, times_ms, marker="o")
plt.xlabel("Number of threads (t)")
plt.ylabel("Time (ms)")
plt.title("Parallel convolve, n = 1024")
plt.xticks(range(1, 21))
plt.grid(True, ls="--", linewidth=0.5)
plt.tight_layout()
plt.savefig("task2.pdf")
print("Saved task2.pdf")