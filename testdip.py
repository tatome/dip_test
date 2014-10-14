import dip
import numpy as np
import bz2

# data
statfaculty = map(int, "1001011205411322223121252002013441001000102")

def test_statfaculty():
    # check that we get the same result as the R implementation on the 
    # statfaculty data set.
    assert round(dip.dip(statfaculty)[0], 8) == 0.05952381
    assert round(dip.dip(statfaculty[::-1])[0], 8) == 0.05952381

    # Check that our implementation produces the same dips as R on random data.
    maxdiff = 1e-8,
    for filename in ['test-5.csv.bz2', 'test-10.csv.bz2', 'test-100.csv.bz2', \
                     'test-1000.csv.bz2']:
        with bz2.BZ2File(filename) as infile:
            data = np.array([np.fromstring(l, sep=',') for l in infile])

        # Random samples are in the first n-1 columns, dips computed by R are 
        # in last column.
        dips = np.array([dip.dip(idxs = d[:-1])[0] for d in data])
        diff = np.abs(dips - data[:,-1])
        
        assert max(diff) < maxdiff, "R computed %s where we computed %s" % \
                    (data[diff >= maxdiff][-1], dips[diff >= maxdiff])
