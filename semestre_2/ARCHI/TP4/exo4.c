int fac(int n){
	return (n<=1) ? 1 : n * fac(n-1);
}
int fac2_rec(int n, int acc){
	return (n<=1) ? acc : fac2_rec(n-1, n * acc);
}
int fac2(int n){
	return fac2_rec(n,1);
}

