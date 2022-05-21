# Чисельні методи <br> Лабораторна робота №2 <br> Методи 1 та 4, розмірність 4×4
###### Віннічук Назар <br> Група К-25

### Метод Гаусса

$$
    \left(
    \begin{array}{cccc|c}
        1 & 2 & 1 & 1 & 23 \\
        5 & 2 & 1 & 2 & 36 \\
        7 & 1 & 3 & 1 & 35 \\
        3 & 5 & 2 & 1 & 42 \\
    \end{array}
    \right)
$$

```python
from numpy import *

sle = array([
    [1, 2, 1, 1, 23],
    [5, 2, 1, 2, 36],
    [7, 1, 3, 1, 35],
    [3, 5, 2, 1, 42],
])

n = len(sle)
set_printoptions(precision=2, suppress=True)

print("Прямий хід:\n")

a = copy(sle)
det = 1

for k in range(n):
    l = argmax(abs(a[:,k]))

    if l != k:
        det *= -1

    p = identity(n)
    p[[l, k]] = p[[k, l]]

    print("P:")
    print(p)

    a_ = p @ a
    det *= a_[k][k]

    m = identity(n)
    m[k][k] = 1 / a_[k][k]

    for i in range(k + 1, n):
        m[i][k] = -a_[i][k] / a_[k][k]

    print("M:")
    print(m)

    a = m @ a_

    print("A:")
    print(a)
    print()

print("Зворотній хід:\n")

xs = array([])

for i in range(n):
    j = n - 1 - i
    xs = append(xs, a[j][n] - sum(a[j][j + 1:n] * xs))
    print(xs[::-1])

print("\nВизначник:", det)
```

### Метод Якобі

$$
    \left(
    \begin{array}{cccc|c}
        7 & 1 & 3 & 1 & 35 \\
        3 & 6 & 3 & 0 & 42 \\
        1 & 2 & 5 & 1 & 43 \\
        2 & 2 & 1 & 5 & 60 \\
    \end{array}
    \right)
$$

$$
    \begin{cases}
        |7| \geq |1| + |3| + |1| = 5 \\
        |6| \geq |3| + |3| + |0| = 6 \\
        |5| \geq |1| + |2| + |1| = 4 \\
        |5| \geq |2| + |2| + |1| = 5 \\
    \end{cases}
$$

$$ ||x|| = {||x||}_{\infty} $$
$$ \epsilon = 0.001 $$

```python
a = array([
    [7, 1, 3, 1, 35],
    [3, 6, 3, 0, 42],
    [1, 2, 5, 1, 43],
    [2, 2, 1, 5, 60],
])

epsilon = 0.001

set_printoptions(precision=3, suppress=True)

def norm(xs):
    return max(abs(x) for x in xs)

xs = array([.0, .0, .0, .0])

while True:
    new_xs = copy(xs)

    for i in range(n):
        zeroed_i_xs = copy(xs)
        zeroed_i_xs[i] = 0
        new_xs[i] = (-sum(zeroed_i_xs * a[i][:n]) + a[i][n]) / a[i][i]

    print(new_xs, f"Норма: {norm(new_xs - xs):.4f}")

    if norm(new_xs - xs) <= epsilon:
        break

    xs = new_xs
```

### Число обумовленості

```python
from numpy.linalg import inv

a = delete(a, 4, axis=1)
ai = inv(a)

def norm(a):
    return max(sum(abs(a[i])) for i in range(n))

print(a)
print("Норма:", norm(a))
print()
print(ai)
print("Норма:", norm(ai))
print()
print("Число обумовленості:", norm(a) * norm(ai))
```


<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
