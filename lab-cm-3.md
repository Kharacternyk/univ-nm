# Комп'ютерне моделювання <br> Лабораторна робота №3

###### Віннічук Назар <br> МІ-3

#### №1

> Знайти наближений розв'язок крайової задачi методом прогонки в точках $x_k = kh$,
> $h = 0.1$, $k = \overline{1, 10}$, $x \in [0; 1]$:
>
> $$
> \begin{cases}
> y''(x) − (x + y)y'(x) − y(x) = \frac{2}{(x + 1)^3} \\
> y(0) = 1 \\
> y(1) = 0.5 \\
> \end{cases}
> $$

Побудуємо систему нелінійних у нашому випадку рівнянь.

$$
y'_i = \frac{y_{i+1} - y_{i-1}}{2h} + O(h^2) \\
y''_i = \frac{y_{i+1} - 2y_i + y_{i-1}}{h^2} + O(h^2) \\
\frac{y_{i+1} - 2y_i + y_{i-1}}{h^2} - \frac{(x_i+y_i)(y_{i+1} - y_{i-1})}{2h}
- y_i = \frac{2}{(x_i+1)^3} + O(h^2) \\
y_{i+1}(\frac{1}{h^2} - \frac{x_i+y_i}{2h}) - y_i(\frac{2}{h^2} + 1)
+ y_{i-1}(\frac{1}{h^2} + \frac{x_i+y_i}{2h}) = \frac{2}{(x_i+1)^3} + O(h^2) \\
y_{i+1} \approx \frac{\frac{2}{(x_i+1)^3} + y_i(\frac{2}{h^2} + 1) -
y_{i-1}(\frac{1}{h^2} + \frac{x_i+y_i}{2h})}{\frac{1}{h^2} - \frac{x_i+y_i}{2h}} \\
y_{i-1} \approx \frac{\frac{2}{(x_i+1)^3} + y_i(\frac{2}{h^2} + 1) -
y_{i+1}(\frac{1}{h^2} - \frac{x_i+y_i}{2h})}{\frac{1}{h^2} + \frac{x_i+y_i}{2h}} \\
y_2 \approx \frac{\frac{2}{1.2^3} + 1(200 + 1) - 1(100 + \frac{2 + y_1}{0.2})}
{100 - \frac{2 + y_1}{0.2}} = \frac{a + by_1}{c + dy_1} \\
y_3 \approx \frac{m + ly_2 - sy_1}{n + ty_2} = \frac{a' + b'y_1 + c'y_1^2}{d' + e'y_1}
$$

Запишемо умову у термінах мови програмування.

```python
h = 0.1
x_0 = 0
xs = [x_0 + k * h for k in range(1, 11)]
equations = []

# :-(
```

#### №2

> Знайти наближений розв'язок крайової задачi методом пристрiлювання в точках $x_k = kh$,
> $h = 0.1$, $k = \overline{1, 10}$, $x \in [0; 1]$:
>
> $$
> \begin{cases}
> y''(x) + \frac{2}{x-2}y′(x) + (x − 2)y(x) = 1 \\
> y(0) = −0.5 \\
> y(1) = −1 \\
> \end{cases}
> $$

Перепишемо умову.

$$
\begin{cases}
y' = z \\
z' = 1 - \frac{2}{x-2}z - (x − 2)y \\
y(0) = −0.5 \\
y(1) = −1 \\
\end{cases}
$$

$$
\begin{cases}
y_{i+1} = y_i + hz_i \\
z_{i+1} = z_i + h(1 - \frac{2}{x_i-2}z_i - (x_i − 2)y_i) \\
y(0) = −0.5 \\
z(0) = \tan(\alpha)
\end{cases}
$$

Похибка не вказана в умові. Покладемо $\epsilon = 0.01$.

```python
from math import pi, tan, atan

epsilon = 0.01
y_0 = -0.5
y_last = -1

def compute_ys(tg_alpha):
    ys = [y_0]
    zs = [tg_alpha]
    for i in range(len(xs)):
        x = xs[i]
        y = ys[i]
        z = zs[i]
        ys.append(y + h * z)
        zs.append(z + h * (1 - 2 / (x - 2) * z - (x - 2) * y))
    return ys

def shoot(alpha, min_alpha, max_alpha, iteration):
    ys = compute_ys(tan(alpha))
    print(f"{iteration}:\talpha = {alpha}\tdelta = {ys[-1] - y_last}")
    if ys[-1] - y_last > epsilon:
        return shoot((min_alpha + alpha) / 2, min_alpha, alpha, iteration + 1)
    if ys[-1] - y_last < -epsilon:
        return shoot((max_alpha + alpha) / 2, alpha, max_alpha, iteration + 1)
    return ys

shoot(atan(y_last - y_0), -pi/2, pi/2, 1)
```

<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
