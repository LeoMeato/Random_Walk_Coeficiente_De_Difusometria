import matplotlib.pyplot as plt
import numpy as np

with open("pontos.txt", "r") as f:
    y = [float(i) for i in f.readlines()]
    x = list(range(len(y)))
    plt.plot(x, y)
    plt.yticks(np.linspace(0, 0.00001, 5))
    plt.show()