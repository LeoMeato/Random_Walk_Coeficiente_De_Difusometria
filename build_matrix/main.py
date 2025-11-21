import matplotlib.pyplot as plt

with open("pontos.txt", "r") as f:
    y = [float(i) for i in f.readlines()]
    x = list(range(len(y)))
    plt.plot(x, y)
    plt.show()