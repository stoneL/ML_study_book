"""
比较几个函数的效率
"""
import timeit

normal_py_sec = timeit.timeit('sum(x*x for x in xrange(1000))',
                              number=10000)
naive_np_sec = timeit.timeit('sum(na*na)',
                             setup="import numpy as np; na=np.arange(1000)",
                             number=10000)
good_np_sec = timeit.timeit('na.dot(na)',
                            setup="import numpy as np; na=np.arange(1000)",
                            number=10000)

print("Normal Python: %f sec" % normal_py_sec)
print("Naive NumPy: %f sec" % naive_np_sec)
print("Good NumPy: %f sec" % good_np_sec)

"""
Normal Python: 0.849678 sec
Naive NumPy: 1.109494 sec
Good NumPy: 0.018604 sec
可以看见dot（矩阵乘法的效率是很高的）
"""
