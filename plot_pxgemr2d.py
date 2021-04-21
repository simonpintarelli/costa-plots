import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

plt.style.use("seaborn-white")
sns.set_style("whitegrid", {"legend.frameon": True})
# Direct input
plt.rcParams["text.latex.preamble"] = [r"\usepackage{lmodern}"]
# Options
params = {
    "text.usetex": True,
    "font.size": 15,
    "font.family": "lmodern",
    # 'text.latex.unicode': True
}
plt.rcParams.update(params)


def times(filename, pattern):
    with open(filename, "r") as f:
        lines = f.readlines()
    result = []

    for line in lines:
        if pattern in line:
            split_line = line.split(" ")
            result.append(float(split_line[-2]))

    return result


pattern = "COSTA TIMES [ms]"

nodes = range(100*1000, 220*1000, 20*1000)

costa_times = times("pxgemr2d_costa_results.out", "COSTA TIMES [ms]")
cray_times = times("pxgemr2d_cray_results.out", "SCALAPACK TIMES [ms]")
mkl_times = times("pxgemr2d_mkl_results.out", "SCALAPACK TIMES [ms]")

sns.set_palette("deep")
palette = sns.color_palette("deep", 6)

fig = plt.figure(figsize=(5, 4))
fig.suptitle("Data Reshuffling (pdgemr2d)", fontsize=16)

ax = fig.add_subplot(111)


# @ticker.FuncFormatter
# def major_formatter(x, pos):
#     return r'$%d\times10^{%d}$' % (x/10000, 4)

ax.plot(nodes, costa_times, linewidth=3, label="COSTA")
ax.plot(nodes, cray_times, linewidth=3, label="Cray-libsci")
ax.plot(nodes, mkl_times, linewidth=3, label="MKL")
plt.ticklabel_format(style='sci', axis='x', scilimits=(0,0))
# ax.xaxis.set_major_formatter(major_formatter)

ax.set_xlabel(r"square matrix dimension", fontsize=14)
ax.set_ylabel(r"Time [s]", fontsize=14)

ax.legend(frameon=True)

fig.tight_layout()
fig.subplots_adjust(top=0.86)
fig.savefig("pxgemr2d.pdf")
plt.show()
