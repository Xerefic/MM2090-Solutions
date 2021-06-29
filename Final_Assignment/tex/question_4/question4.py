import numpy as np

import cv2

import matplotlib.pyplot as plt

# Initializing the State
n = 128
state = np.zeros((n,n))

plt.imshow(state)

# Randomly identifying a start location
start = ( int(n/3+np.random.rand()*n/3), int(n/3+np.random.rand()*n/3) )

# Evolving the State
N = 2*10**4 # Number of timesteps

pos = start
orient = 0
for time in range(N):
    # Updating the current state
    if state[pos]==0.0:
        state[pos] = 255.0
        orient = (orient+1)%4 # Turning clockwise
    elif state[pos]==255.0:
        state[pos] = 0.0 
        orient = (orient+3)%4 # Turning anti-clockwise
    
    # Finding the next state
    if orient == 0:
        if pos[1]-1>0:
            pos = (pos[0], pos[1]-1)
    elif orient == 1:
        if pos[0]+1<n:
            pos = (pos[0]+1, pos[1])
    elif orient == 2:
        if pos[1]+1<n:
            pos = (pos[0], pos[1]+1)
    elif orient == 3:
        if pos[0]-1>0:
            pos = (pos[0]-1, pos[1])
            
    if time<1500:
        if time%100==0:
            fname = "Iteration-"+str(time)+".png"
            cv2.imwrite(fname, state)
    else:
        if time%1000==0:
            fname = "Iteration-"+str(time)+".png"
            cv2.imwrite(fname, state)