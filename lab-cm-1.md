# Комп'ютерне моделювання <br> Лабораторна робота №1
###### Віннічук Назар <br> МІ-3

#### №1

> Знайти наближене значення числа π з 5
> правильними значущими цифрами за його iнтегральним
> представленням π = $\int_0^1\frac{4}{1+x^2}\,dx$
> за допомогою квадратурної формули 1) лiвих прямокутникiв;
> 2) трепецiй; 3) Сiмпсона. Використати
> правило Рунге. Яку кiлькiсть значень пiдiнтегральної
> функцiї необхiдно використати в кожному випадку?

Побудуємо графік підінтегральної функції.

```python
import matplotlib.pyplot as pyplot
import numpy

def f(x):
    return 4 / (1 + x**2)

pyplot.plot(numpy.linspace(0, 1), f(numpy.linspace(0, 1)))
pyplot.grid(True)
pyplot.show()
```

Реалізуємо універсальну функцію правила Рунге та функції інтегрування
різними методами для підстановки в неї.

```python
def runge(function, bounds, precision, precision_rank, integrate):
    node_count = 2
    integrals = [
        (node_count, integrate(function, bounds, node_count)),
        (node_count * 2, integrate(function, bounds, node_count * 2)),
    ]
    while abs(integrals[-1][1] - integrals[-2][1]) / (2**precision_rank - 1) > precision:
        node_count *= 2
        integrals.append((node_count * 2, integrate(function, bounds, node_count * 2)))
    return integrals


def step(bounds, node_count):
    return (bounds[1] - bounds[0]) / (node_count - 1)


def nodes(bounds, node_count):
    return numpy.linspace(*bounds, node_count)


def integrate_via_left_rectangles(function, bounds, node_count):
    return step(bounds, node_count) * sum(map(function, nodes(bounds, node_count)[:-1]))


def integrate_via_trapezoids(function, bounds, node_count):
    xs = nodes(bounds, node_count)
    return (
        step(bounds, node_count) * (
            function(xs[0]) / 2 +
            function(xs[-1]) / 2 +
            sum(map(function, xs[1:-1]))
        )
    )


def integrate_via_simpson(function, bounds, node_count):
    xs = nodes(bounds, node_count)
    half_xs = [(xs[i] + xs[i + 1]) / 2 for i in range(len(xs) - 1)]
    return (
        step(bounds, node_count) / 6 * (
            function(xs[0]) +
            function(xs[-1]) +
            4 * sum(map(function, half_xs)) +
            2 * sum(map(function, xs[1:-1]))
        )
    )
```

Викличемо функцію правила Рунге з різними методами інтергування,
підставляючи підінтегральну функцію, межі та точність з умови,
а також відповідний кожному методу порядок точності.
Функція правила Рунге повертає список з кількості використаних вузлів та
наближених значень інтегралу на кожному кроці,
тобто останнє значення є кінцевим результатом,
що задовольняє задану точність.

У методі лівих прямокутників фактична кількість обчислених значень функції на кожному кроці
рівна $n-1$, де $n$ — виведена кількість вузлів.
У методі трапецій фактична кількість обчислених значень функції на кожному кроці
рівна $n$.
У методі Сімпсона фактична кількість обчислених значень функції на кожному кроці
рівна $2n-1$ через використання половинних індексів.

###### Метод лівих прямокутників

```python
runge(f, (0, 1), 5e-5, 1, integrate_via_left_rectangles)
```

###### Метод трапецій

```python
runge(f, (0, 1), 5e-5, 2, integrate_via_trapezoids)
```

###### Метод Сімпсона

```python
runge(f, (0, 1), 5e-5, 4, integrate_via_simpson)
```

#### №14

> Наближено обчислити iнтеграл $I = \int_0^1 \frac{dx}{\sqrt{x(1+x^2)}}$
> за допомогою методу обрiзання
> границь з точнiстю $\epsilon = 0.5$. Використати метод
> лiвих прямокутникiв, оцiнку залишкових членiв.

Побудуємо графік підінтегральної функції.

```python
def f(x):
    return 1 / (x * (1 + x*x))**0.5

pyplot.plot(numpy.linspace(0.0001, 1), f(numpy.linspace(0.0001, 1)))
pyplot.grid(True)
pyplot.show()
```

Розіб'ємо інтеграл.

$$
    \int_0^1 \frac{dx}{\sqrt{x(1+x^2)}} =
    \int_0^\delta \frac{dx}{\sqrt{x(1+x^2)}} +
    \int_\delta^1 \frac{dx}{\sqrt{x(1+x^2)}} = I_1 + I_2
$$
$$
    I_1 \le \int_0^\delta \frac{dx}{\sqrt{x}} = 2\sqrt{x} \Bigr|_0^\delta
    = 2\sqrt{\delta}
$$

Нехай $\delta = 0.01$, тоді $I_1 <= 0.2$, тоді $I_2$ необхідно обчислити з точністю
$0.3$ задля досягнення сумарної точності $0.5$. Оцінемо залишковий член:

$$
    f(x) = \frac{1}{\sqrt{x(1+x^2)}}
$$
$$
    f'(x) = -\frac{3x^2 + 1}{2(x^3 + x)^{3/2}}
$$
$$
    |R(f)|
    \le \frac{(\max_{x \in [0.01, 1]}{f'(x)})(1-0.01)h}{2}
    \le \frac{4h}{0.02}
    = 200h
$$
$$
    |R(f)| \le 0.3 \Leftarrow h = 0.001
$$

```python
integrate_via_left_rectangles(f, (0.01, 1), 991)
```

<a href="https://www.wolframalpha.com/input?i=integral+from+0+to+1+1%2Fsqrt%28x%281%2Bx%5E2%29%29">
    Справжнє значення інтегралу
</a>
$1.85$.

#### №29

> Наближено обчислити iнтеграл
> $I = \int_0^\infty \ln\tanh\frac{x}{2}\,dx$
> за формулою Гауса для $n = 2$. Оцiнити похибку.

Побудуємо графік підінтегральної функції.

```python
def f(x):
    return numpy.log((numpy.exp(x) - 1) / (numpy.exp(x) + 1)) / numpy.exp(-x)

pyplot.plot(numpy.linspace(0.0001, 10), f(numpy.linspace(0.0001, 10)))
pyplot.grid(True)
pyplot.show()
```

Я не зміг розв'язати цю задачу методом Гауса зі скінченною апріорною похибкою.
Проте, розв'язок методом Гауса з поліномами Лежандра дав на диво гарну
апостеріорну похибку у $0.1$.

<a href="https://www.wolframalpha.com/input?i=integral+from+0+to+inf+ln+tanh+x%2F2">
    Справжнє значення інтегралу
</a>
$-2.47$.

##### Поліноми Лежандра
$$
    \int_0^\infty \ln\tanh\frac{x}{2}\,dx
    = \int_0^\infty \ln\frac{e^x-1}{e^x+1}\,dx
    = \int_0^1 \frac{1}{t}\ln\frac{e^{-\ln{t}}-1}{e^{-\ln{t}}+1}\,dt = \\
    = \int_0^1 \frac{1}{t}\ln\frac{\frac{1}{t}-1}{\frac{1}{t}+1}\,dt
    = \int_{-1}^1 \frac{1}{1+k}\ln\frac{\frac{2}{1+k}-1}{\frac{2}{1+k}+1}\,dk
    = \int_{-1}^1 \frac{1}{1+k}\ln\frac{1-k}{3+k}\,dk
$$

Використаємо поліноми Лежандра:

$$
    L_2(x) = 0 \Rightarrow k_1 = \frac{1}{\sqrt{3}}, k_2 = -\frac{1}{\sqrt{3}}, c_1 = c_2 = 1
$$

```python
def f_1(k):
    return 1 / (1 + k) * numpy.log((1 - k) / (3 + k))

f_1(1/numpy.sqrt(3)) + f_1(-1/numpy.sqrt(3))
```

$$
    |R(f)| \le \frac{\max_{x \in [-1; 1]}|(\frac{1}{1+k}\ln\frac{1-k}{3+k})^{IV}|2^5(2!)^4}
    {5(4!)^3} = \infty
$$

##### Поліноми Лагера

$$
    \int_0^\infty \ln\tanh\frac{x}{2}\,dx
    = \int_0^\infty \ln\frac{e^x-1}{e^x+1}\,dx
    = \int_0^\infty \frac{e^{-x}}{e^{-x}}\ln\frac{e^x-1}{e^x+1}\,dx
$$

Використаємо поліноми Лагера для $\alpha = 0$:

$$
    L_2^0(x) = x^2 - 4x + 3 = (x-1)(x-3) \Rightarrow x_1 = 1, x_2 = 3 \\
    c_1 = \frac{2!2!}{1(2 - 4)} = \frac{4}{-2} = -2 \\
    c_2 = \frac{2!2!}{3(6 - 4)} = \frac{4}{6} = \frac{2}{3}
$$

```python
-2 * f(1) + 2/3 * f(3)
```

$$
    |R(f)| \le M_{2n}\frac{2!2!}{4!} = \frac{M_{2n}}{6} = \infty
$$

<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
