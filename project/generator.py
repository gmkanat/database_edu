import random
import time
import names

def str_time_prop(start, end, time_format, prop):
    """Get a time at a proportion of a range of two formatted times.

    start and end should be strings specifying times formatted in the
    given format (strftime-style), giving an interval [start, end].
    prop specifies how a proportion of the interval to be taken after
    start.  The returned time will be in the specified format.
    """

    stime = time.mktime(time.strptime(start, time_format))
    etime = time.mktime(time.strptime(end, time_format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(time_format, time.localtime(ptime))


def random_date(start, end, prop):
    return str_time_prop(start, end, '%d-%m-%Y', prop)
"""print('insert into buyer values ', end=" ")
for _ in range(0):
    out = '('
    print(random_date("1-1-2015", "3-12-2021", random.random()))
for i in range(1, 21):
    print('(', i, ', ', round(random.random()*100), ')', end=", ")
print(';')"""
a = [1, 3, 4, 6, 9, 12, 14, 15, 17, 18]
b = [2, 5, 7, 8, 10, 11, 13, 16, 19, 20]
for i in a:
    print('insert into info_online values ', end=" ")
    print("({0}, {1})".format(i, '1'),  end=";\n")
    # print('insert into info_store values ', end=" ")
    # print("({1}, {0})".format(i, 2*i),  end=";\n")
    # print('insert into prod values ', end=" ")
    # print("({1}, {0})".format(i, 5*i-2),  end=";\n")
    # print('insert into prod values ', end=" ")
    # print("({1}, {0})".format(i, 5*i-1),  end=";\n")
    # print('insert into prod values ', end=" ")
    # print("({1}, {0})".format(i, 5*i),  end=";\n")
    # print("'", end='')
    # print(random_date("1-1-2021", "3-12-2021", random.random()), end = "');\n")
    # print('insert into buy values ', end=" ")
    # print("({0}, {1})".format(i, 3*i - 1), end = ";\n")
print()
# for i in range(1,200):
#     if i%29 != 0:
#         print("({0}, {1})".format(i, i%29),  end=", ")
#     else:
#         print("({0}, {1})".format(i, i%29 + 1),  end=", ")
# for i in range(100):
#     print(names.get_first_name())