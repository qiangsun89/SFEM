//
// Created by qiang on 2021/12/5.
//

#ifndef SFEM_BLAS1_D_H
#define SFEM_BLAS1_D_H
double dasum ( int n, double x[], int incx );
void daxpy ( int n, double da, double dx[], int incx, double dy[], int incy );
void dcopy ( int n, double dx[], int incx, double dy[], int incy );
double ddot ( int n, double dx[], int incx, double dy[], int incy );
double dnrm2 ( int n, double x[], int incx );
void drot ( int n, double x[], int incx, double y[], int incy, double c,
            double s );
void drotg ( double *sa, double *sb, double *c, double *s );
void dscal ( int n, double sa, double x[], int incx );
void dswap ( int n, double x[], int incx, double y[], int incy );
int idamax ( int n, double dx[], int incx );
#endif //SFEM_BLAS1_D_H
