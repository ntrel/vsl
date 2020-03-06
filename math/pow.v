// Copyright (c) 2019-2020 Ulises Jeremias Cornejo Fandos. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.

module math

#include <math.h>

// pow returns base raised to the provided power.
pub fn pow(a, b f64) f64 {
	return C.pow(a, b)
}

const (
        // pow10tab stores the pre-computed values 10**i for i < 32.
        pow10tab = [
            f64(1e+00), 1e+01, 1e+02, 1e+03, 1e+04, 1e+05, 1e+06, 1e+07, 1e+08, 1e+09,
                1e+10, 1e+11, 1e+12, 1e+13, 1e+14, 1e+15, 1e+16, 1e+17, 1e+18, 1e+19,
                1e+20, 1e+21, 1e+22, 1e+23, 1e+24, 1e+25, 1e+26, 1e+27, 1e+28, 1e+29,
                1e+30, 1e+31,
        ]

        // pow10postab32 stores the pre-computed value for 10**(i*32) at index i.
        pow10postab32 = [
                f64(1e+00), 1e+32, 1e+64, 1e+96, 1e+128, 1e+160, 1e+192, 1e+224, 1e+256, 1e+288,
        ]

        // pow10negtab32 stores the pre-computed value for 10**(-i*32) at index i.
        pow10negtab32 = [
                f64(1e-00), 1e-32, 1e-64, 1e-96, 1e-128, 1e-160, 1e-192, 1e-224, 1e-256, 1e-288, 1e-320,
        ]
)

// pow10 returns 10**n, the base-10 exponential of n.
//
// special cases are:
//	pow10(n) =    0 for n < -323
//	pow10(n) = +inf for n > 308
pub fn pow10(n int) f64 {
	if 0 <= n && n <= 308 {
		return pow10postab32[u32(n)/32] * pow10tab[u32(n)%32]
	}

	if -323 <= n && n <= 0 {
		return pow10negtab32[u32(-n)/32] / pow10tab[u32(-n)%32]
	}

	// n < -323 || 308 < n
	if n > 0 {
		return inf(1)
	}

	// n < -323
	return f64(0)
}