import numpy as np

a = np.array([[1,2,3],[4,5,6]])
print(a.shape) #(2, 3)

b = np.array([1,2,3,4], ndmin=3)
print(b) #[[[1 2 3 4]]]
print(b.shape) #(1, 1, 4) index값이 아닌 shape
