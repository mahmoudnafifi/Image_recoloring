#include <stdlib.h>
#include "mex.h"
#include "emd__.cpp"


//in Matlab:
//call [distances]=EMD2(features1,feature2,weights1,weights2,size);
// feature2 and weights2 are array of features and weights
// size is the size of the array
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	
	feature_t *f1, **f2;
	float *w1, **w2;
	signature_t s1;
	float*       e;
	flow_t*      flow;
	int      flowSize;
	signature_t** s2;
	double *f1_mat, *f2_mat;
	double *w1_mat, *w2_mat;
	mwSize palette1_size, palette2_size;
	double *out_matrix1, *out_matrix2;
	double* size;
	int i, j;
	
	palette1_size = mxGetM(prhs[0]);
	palette2_size = mxGetM(prhs[1]); //we assume the second palette has the same size of the first one
	f1_mat = mxGetPr(prhs[0]); // each row is a color
	f2_mat = mxGetPr(prhs[1]); // each row is a color
	w1_mat = mxGetPr(prhs[2]);
	w2_mat = mxGetPr(prhs[3]);
    size = mxGetPr(prhs[4]); //size of the array of data points

    s2=new signature_t*[(int)(*size)];
    f2=new feature_t*[(int)(*size)];
    w2=new float*[(int)(*size)];
    /*allocate features and weights to S*/
     
	flow = new flow_t[palette1_size + palette1_size];
	e=new float[(int)(*size)];
    
	f1 = new feature_t[palette1_size]; 
    //initialize the first signature
	w1 = new float[palette1_size]; 
	for (i=0; i<palette1_size; i++)
	{
		f1[i].X = f1_mat[                    i];
		f1[i].Y = f1_mat[palette1_size     + i];
		f1[i].Z = f1_mat[palette1_size * 2 + i];
		w1[i] = (float)w1_mat[i];
		
	}
    s1 = { palette1_size, f1, w1 }; //first signature
    int count=0;
  	for (int s_=0;s_<int(*size); s_++)
    {   
        s2[s_]=new signature_t;
        f2[s_]=new feature_t[palette1_size];
        w2[s_]=new float[palette1_size];
        for (i=0; i<palette1_size; i++)
        {   
            f2[s_][i].X = f2_mat[s_*palette1_size+                     i];
            f2[s_][i].Y = f2_mat[s_*palette1_size+     palette2_size + i];
            f2[s_][i].Z = f2_mat[s_*palette1_size+    2*palette2_size+ i];
            w2[s_][i] = (float)w2_mat[count++];
    	}
        s2[s_]->n=palette1_size;
        s2[s_]->Features=f2[s_];
        s2[s_]->Weights=w2[s_];

     }
	
	
	   
	e = emd2(&s1, s2, int(*size), flow, &flowSize);
    /*float* emd2(signature_t *Signature1, signature_t *Signature2[], int size,
	flow_t *Flow, int *FlowSize)*/
    /*float* emd3(signature_t *Signature[], int size,
	flow_t *Flow, int *FlowSize)*/
	
	plhs[0] = mxCreateDoubleMatrix(int(*size), 1, mxREAL);

	out_matrix1 = mxGetPr(plhs[0]);
	for (int out=0;out<=int(*size);out++)
        out_matrix1[out] = (double)e[out];
     free(f1); free(w1);
    for (int s_=0;s_<int(*size); s_++)
    { 
        delete(f2[s_]);
        delete(w2[s_]);
    }

} // end (void) mexFunction

