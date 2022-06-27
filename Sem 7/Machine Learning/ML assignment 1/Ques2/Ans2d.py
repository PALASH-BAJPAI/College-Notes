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
d = 3
n = len(input_data)-1
prob = [0.5,0.5,0]

means = []
cov = []
for i in range(len(input_data)):
    means.append(input_data[i].mean(axis=0))
    cov.append(np.cov(input_data[i].T))
means= np.array(means)
cov=np.array(cov)

#Looping each dataset from input_data

for i in range(n+1):
    count,total_count = 0,0
    print("\nData classes should be classified as:", i+1)
    
    # Taking x as dataset belonging to class i + 1
    for x in input_data[i]:
        #g_values is an array for all discrminant function output
        g_values = [0 for _ in range(n)]        

        for j in range(n):
            g_values[j] = dis_func(x,prob[j],means[j],cov[j],d)

        result = g_values.index(max(g_values)) + 1
        print(x, "\t       classified as", result)
        total_count, count = total_count + 1, (count + 1 if i == result - 1 else count)
    
    success=(count/total_count)*100
    print("Rate of Success:",success,"%")
    print("Rate of Failure:", 100 - success,"%")
