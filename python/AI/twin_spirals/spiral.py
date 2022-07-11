# spiral.py
# ZZEN9444, CSE, UNSW

import torch
import torch.nn as nn
import matplotlib.pyplot as plt

import numpy as np

class PolarNet(torch.nn.Module):
    def __init__(self, num_hid):
        super(PolarNet, self).__init__()
        self.input = nn.Linear(2, num_hid) # Input layer
        self.hidden = nn.Linear(num_hid, 1) # Single hidden layer
        self.tanh = nn.Tanh() # Default model is tanh
        self.sigmoid = nn.Sigmoid()

    def forward(self, input):
        # Function for switching Cartesian to polar
        def xy_to_ra(x, y):
            r = np.sqrt(x*x + y*y)
            a = np.arctan2(y, x)
            output = np.array([r, a],).transpose()
            return output
        
        output = input.detach().cpu().numpy()
        output = xy_to_ra(output[:,0], output[:,1])
        output = torch.from_numpy(output)

        # Network process
        output = self.input(output)
        output = self.tanh(output); self.layer1 = output
        output = self.hidden(output)
        output = self.sigmoid(output)

        return output

class RawNet(torch.nn.Module):
    def __init__(self, num_hid):
        super(RawNet, self).__init__()
        self.input = nn.Linear(2, num_hid) # Input layer
        self.hidden1 = nn.Linear(num_hid, num_hid) # First hidden layer
        #self.hidden11 = nn.Linear(num_hid, num_hid) # Third layer (experimentation)
        self.hidden2 = nn.Linear(num_hid, 1) # Third hidden layer (for experimentation)
        self.tanh = nn.Tanh() # Default model is tanh
        self.sigmoid = nn.Sigmoid()

    def forward(self, input):
        output = self.input(input)
        output = self.tanh(output); self.layer1 = output
        output = self.hidden1(output)
        output = self.tanh(output); self.layer2 = output
        #output = self.hidden11(output); output = self.tanh(output) # Third layer (experimentation)
        output = self.hidden2(output)        
        output = self.sigmoid(output)
        return output

def graph_hidden(net, layer, node):
    # Boilerplate graph configuration from spiral_main
    xrange = torch.arange(start=-7,end=7.1,step=0.01,dtype=torch.float32)
    yrange = torch.arange(start=-6.6,end=6.7,step=0.01,dtype=torch.float32)
    xcoord = xrange.repeat(yrange.size()[0])
    ycoord = torch.repeat_interleave(yrange, xrange.size()[0], dim=0)
    grid = torch.cat((xcoord.unsqueeze(1),ycoord.unsqueeze(1)),1)

    with torch.no_grad(): # suppress updating of gradients
        net.eval()        # toggle batch norm, dropout
        output = net(grid)

        if layer == 1:
            pred = (net.layer1[:, node] >= 0).float()
        elif layer == 2:
            pred = (net.layer2[:, node] >= 0).float()
        else:
            pass

        # plot function computed by model
        plt.clf()
        plt.pcolormesh(xrange,yrange,pred.cpu().view(yrange.size()[0],xrange.size()[0]), cmap='Wistia')
