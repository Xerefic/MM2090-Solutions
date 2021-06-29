import numpy as np
import pandas as pd

import sage.plot.scatter_plot as scatter

import matplotlib.pyplot as plt

def plotTangent(equation):
    deq = equation.derivative(x)
    
    x_data = np.linspace(0, 100, num=50)
    
    # Makes the equation callable
    func = fast_callable(equation, vars=[x])
    slope = fast_callable(deq, vars=[x])
    
    # Plotting the function
    plots = [ (x_data[i], func(x_data[i])) for i in range(len(x_data)) ]
    
    g = Graphics()
    g += scatter.scatter_plot(plots, facecolor='lime')
    
    # Plotting the tangent lines
    p = Graphics()
    data = []
    for i in range(0, len(x_data), 5):
        x0 = x_data[i]
        y0 = func(x_data[i])
        s = slope(x_data[i])

        points = [ (x, y0+s*(x-x0)) for x in [0, x0-y0/s, x0, x0*10] ]
        p += line(points)
        data.append({ "Coordinates": [x0,y0] ,"Slope": s, "X-Intercept": x0-y0/s, "Y-Intercept": y0-s*x0})
        
    mini = min(func(x_data[0]), func(x_data[-1]))
    maxi = max(func(x_data[0]), func(x_data[-1]))
    
    g.save("Plotted.png", axes_labels=['$x$','f($x$)'])
    p.save("Tangents.png", axes_labels=['$x$','f($x$)'], xmin=0, xmax=100, ymin=mini, ymax=maxi)
    
    return p, g, data

p, g, data = plotTangent(0.01*x^2)

# Plotting the Data
g.show()
p.show(xmin=0, xmax=100, ymin=-1, ymax=100)

data = pd.DataFrame(data)
print(data)
