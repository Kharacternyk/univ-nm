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

Побудуємо СЛАР.

$$
y'_i = \frac{y_{i+1} - y_{i-1}}{2h} + O(h^2) \\
y''_i = \frac{y_{i+1} - 2y_i + y_{i-1}}{h^2} + O(h^2) \\
\frac{y_{i+1} - 2y_i + y_{i-1}}{h^2} - \frac{(x_i+y_i)(y_{i+1} - y_{i-1})}{2h}
- y_i = \frac{2}{(x_i+1)^3} + O(h^2) \\
y_{i+1}(\frac{1}{h^2} - \frac{x_i+y_i}{2h}) - y_i(\frac{2}{h^2} + 1)
+ y_{i-1}(\frac{1}{h^2} + \frac{x_i+y_i}{2h}) = \frac{2}{(x_i+1)^3} + O(h^2)
$$

Запишемо умову у термінах мови програмування.

```python
h = 0.1
x_0 = 0
xs = [x_0 + k * h for k in range(1, 11)]

def equation(i):
    pass
```

#### №2

> Знайти наближений розв’язок крайової задачi методом пристрiлювання в точках $x_k = kh$,
> $h = 0.1$, $k = \overline{1, 10}$, $x \in [0; 1]$:
>
> $$
> \begin{cases}
> y''(x) + \frac{2}{x-2}y′(x) + (x − 2)y(x) = 1 \\
> y(0) = −0.5 \\
> y(1) = −1 \\
> \end{cases}
> $$

<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
