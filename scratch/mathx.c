#include "mathx.h"

    int clamp(int v, int lo, int hi)
    {
        if (v < lo)
        {
            return lo;
        }
        else if (v > hi)
        {
            return hi;
        }
        else
        {
            return v;
        }
    }