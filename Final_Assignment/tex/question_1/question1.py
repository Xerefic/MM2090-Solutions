import numpy as np

from scipy import optimize


from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import make_pipeline
from sklearn.linear_model import LinearRegression

import matplotlib.pyplot as plt


x_data = np.array(range(1,11))
y_data = -1+2*np.random.rand(10)


plt.figure()
plt.scatter(x_data, y_data, c='green', edgecolors='black')
plt.xlabel("i")
plt.ylabel("Random")
plt.savefig("Points.png", dpi=300)
plt.show()


# Using SciKit Learn to fit a nth degree polynomial
degree=9
polyreg=make_pipeline(PolynomialFeatures(degree),LinearRegression())
polyreg.fit(x_data.reshape(-1,1),y_data)

# Sampling the fitted polynomial
x_fit = np.linspace(1,10, num=100)
y_fit = polyreg.predict(x_fit.reshape(-1,1))

plt.figure()
plt.scatter(x_data,y_data)
plt.plot(x_fit, y_fit,color="black")
plt.title("Polynomial regression with degree "+str(degree))
plt.savefig("Fitted.png", dpi=300)
plt.show()

# Computing the gradient
grad = np.gradient(y_fit, x_fit)

plt.figure()
plt.scatter(x_data, y_data, c='green', edgecolors='black')
plt.plot(x_fit, y_fit,color="blue")
plt.plot(x_fit, grad, color="orange")
plt.ylim([-5,5])
plt.title("Polynomial regression with degree "+str(degree))
plt.show()


x_find = np.linspace(0.1,9.9, num=10000)
extrema_x = []
extrema_y = []

for t in range(1, len(x_find)-1):
    data = x_find[t-1:t+2].reshape(-1,1)
    fit = polyreg.predict(data)
    
    if fit[1]>fit[0] and fit[1]>fit[2]:
        print("Maxima at x =", x_find[t], "and y =", fit[1])
        extrema_x.append(x_find[t])
        extrema_y.append(fit[1])
    elif fit[1]<fit[0] and fit[1]<fit[2]:
        print("Minima at x =", x_find[t], "and y =", fit[1])
        extrema_x.append(x_find[t])
        extrema_y.append(fit[1])


plt.figure()
plt.scatter(x_data, y_data, c='green', edgecolors='black')
plt.scatter(extrema_x, extrema_y, c='red')
plt.plot(x_fit, y_fit,color="blue")
plt.plot(x_fit, grad, color="orange")
plt.ylim([-5,5])
plt.title("Polynomial regression with degree "+str(degree))
plt.show()