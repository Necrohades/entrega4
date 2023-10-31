import matplotlib.pyplot as plt
import random


def lambda_wilks(p, a, b) -> float:
    def beta(i: int):
        return random.betavariate((a + i - p) / 2, p / 2)

    return sum(beta(i) for i in range(1, b + 1))


def plot(p, a, b, n: int):
    plt.hist([lambda_wilks(p, a, b) for _ in range(n)])


def main():
    plot(30, 60, 70, 4000)
    plt.savefig("plot.png")
    plt.show()


if __name__ == '__main__':
    main()
