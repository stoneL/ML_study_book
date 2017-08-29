#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Author  : MarkXu

from numpy import *
import operator


def create_data_set():
    group = array([[1.0, 1.1], [1.0, 1.0], [0, 0], [0, 0.1]])
    labels = ['A', 'A', 'B', 'B']
    return group, labels


def classify0(inx, data_set, labels, k):
    data_set_size = data_set.shape[0]
    diff_mat = tile(inx, (data_set_size, 1)) - data_set
    sq_diff_mat = diff_mat ** 2
    sq_distances = sq_diff_mat.sum(axis=1)
    distances = sq_distances ** 0.5
    sorted_dist_indicies = distances.argsort()
    class_count = {}
    for i in range(k):
        vote_label = labels[sorted_dist_indicies[i]]
        class_count[vote_label] = class_count.get(vote_label, 0) + 1
    sorted_class_count = sorted(class_count.iteritems(), key=operator.itemgetter(1), reverse=True)
    return sorted_class_count[0][0]


def file2matrix(filename):
    fr = open(filename)
    number_of_lines = len(fr.readlines())
    return_mat = zeros((number_of_lines, 3))
    class_label_vector = []
    index = 0
    for line in fr.readlines():
        line = line.strip()
        list_from_line = line.split('\t')



if __name__ == "__main__":
    group, labels = create_data_set()
    classify0([0, 0], group, labels, 3)
