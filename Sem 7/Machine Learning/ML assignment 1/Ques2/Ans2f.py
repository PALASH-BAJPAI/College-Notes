from math import pi, log
import numpy as np

#applying the gi(x) formula on given dataset
#Discriminant Function
def dis_func(x, prob, mean, cov, d): 
    # Checking if the dimensions turn out to be scalars in the case only 1 feature is being taken.
    if d == 1:
        ans = -0.5*(x - mean) * (1/cov)
        ans = ans * (x - mean)
        ans += -0.5*d*log(2*pi) - 0.5*log(cov) 
        ans+=(log(prob) if prob != 0 else 0)
    else:
        temp1 = np.matmul( (x - mean).T,np.matmul(0.5*(x - mean), np.linalg.inv(cov)))
        temp2=0.5*d*log(2*pi)
        temp3=0.5*log(np.linalg.det(cov)) 
        temp4= (log(prob) if prob != 0 else 0)
        ans=-temp1-temp2-temp3+temp4
        
    return ans



#checking for given set of inputs
input_data = [
    np.array([
        [-5.01, -8.12, -3.68],
        [-5.43, -3.48, -3.54],
        [1.08, -5.52, 1.66],
        [0.86, -3.78, -4.11],
        [-2.67, 0.63, 7.39],
        [4.94, 3.29, 2.08],
        [-2.51, 2.09, -2.59],
        [-2.25, -2.13, -6.94],
        [5.56, 2.86, -2.26],
        [1.03, -3.33, 4.33]
    ]),
    np.array([
        [-0.91, -0.18, -0.05],
        [1.30, -2.06, -3.53],
        [-7.75, -4.54, -0.95],
        [-5.47, 0.50, 3.92],
        [6.14, 5.72, -4.85],
        [3.60, 1.26, 4.36],
        [5.37, -4.63, -3.65],
        [7.18, 1.46, -6.66],
        [-7.39, 1.17, 6.30],
        [-7.50, -6.32, -0.31]

    ]),
    np.array([
        [5.35, 2.26, 8.13],
        [5.12, 3.22, -2.66],
        [-1.34, -5.31, -9.87],
        [4.48, 3.42, 5.19],
        [7.11, 2.39, 9.21],
        [7.17, 4.33, -0.98],
        [5.75, 3.97, 6.65],
        [0.77, 0.27, 2.41],
        [0.90, -0.43, -8.71],
        [3.52, -0.36, 6.43]
    ]) 
]

#input_parameters
n = len(input_data)-1
prob = [0.5,0.5,0]

means = []
cov = []
for i in range(len(input_data)):
    means.append(input_data[i].mean(axis=0))
    cov.append(np.cov(input_data[i].T))
means= np.array(means)
cov=np.array(cov)

g_values = [0 for i in range(n)]

#taking input as vector
x=list(map(float,input("Enter vector : ").split()))


# With d=1 (using 1 feature)
d = 1
print("Case 1: Using 1 feature vector ")
for i in range(n):
    g_values[i] = dis_func(x[0], prob[i], means[i][0], cov[i][0][0], d)
result = g_values.index(max(g_values)) + 1
print("\t",x,"\t classified as", result)

# With d=2 (using 2 features)
d = 2
print("Case 2: Using 2 feature vectors ")
for i in range(n):
    g_values[i] = dis_func(x[0:2], prob[i], means[i][0:2], cov[i][0:2, 0:2], d)
result = g_values.index(max(g_values)) + 1
print("\t",x, "\tclassified as", result)

# With d=3(using all features)
d = 3
print("Case 3: Using all feature vectors")
for i in range(n):
    g_values[i] = dis_func(x, prob[i], means[i], cov[i], d)
result = g_values.index(max(g_values)) + 1
print("\t",x,"\t classified as", result)
