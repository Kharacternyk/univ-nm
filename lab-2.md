# Чисельні методи <br> Лабораторна робота №2 <br> Завдання 1 та 4, розмірність 4×4
###### Віннічук Назар <br> Група К-25

### Досліджувана матриця

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

m = array([
    [1, 2, 1, 1, 23],
    [5, 2, 1, 2, 36],
    [7, 1, 3, 1, 35],
    [3, 5, 2, 1, 42],
])

n = len(m)
set_printoptions(precision=2, suppress=True)
```

### Метод Гауса

```python
a = m

print(a)
for k in range(n):
    l = argmax(abs(a[:,k]))
    p = identity(n)
    p[[l, k]] = p[[k, l]]
    a_ = p @ a
    m = identity(n)
    m[k][k] = 1 / a_[k][k]
    for i in range(k + 1, n):
        m[i][k] = -a_[i][k] / a_[k][k]
    a = m @ a_
    print(a)

xs = array([])
for i in range(n):
    j = n - 1 - i
    xs = append(xs, a[j][n] - sum(a[j][j + 1:n] * xs))
xs = xs[::-1]
print(xs)
```


<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
