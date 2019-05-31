#include <stdlib.h>
#include "mex.h"
#include "emd__.cpp"


//in Matlab:
//call [distances]=EMD3(features,weights,size,paletteSize);
// feature2 and weights2 are array of features and weights
// size is the size of the array
// flow (flowSize*3) matrix. Each row contains [from, to, amount of work]
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	
	feature_t **f;
	float **w;
	signature_t s_temp;
	float*       e;
	flow_t*      flow;
	int      flowSize;
	signature_t** s;
	double *f_mat;
	double *w_mat;
   	mwSize palette1_size;
	double *out_matrix1;
	double* size;
	int i, j, size_, Psize;
    
    //we datapoint contains 20-colors
    Psize=20;
	
	f_mat = mxGetPr(prhs[0]); // each row is a color
	w_mat = mxGetPr(prhs[1]);
    size = mxGetPr(prhs[2]); //size of the array of data points == palette1_size/Psize
    
    palette1_size = mxGetM(prhs[0]); //size of each color palette (we assume all data points have the same size)
    size_=(int)(*size); //size of data points
    s=new signature_t*[(int)(*size)];
    f=new feature_t*[(int)(*size)];
    w=new float*[(int)(*size)];
    e=new float[(int)(*size)*((int)(*size)-1)/2];
    /*allocate features and weights to S*/
     
	flow = new flow_t[Psize*2];
    int count=0;
	for (int s_=0;s_<size_; s_++)
    {   
        s[s_]=new signature_t;
        f[s_]=new feature_t[Psize];
        w[s_]=new float[Psize];
        for (i=0; i<Psize; i++)
        {   
            f[s_][i].X = f_mat[s_*Psize+                    i];
            f[s_][i].Y = f_mat[s_*Psize+    palette1_size + i];
            f[s_][i].Z = f_mat[s_*Psize+   2*palette1_size+ i];
            w[s_][i] = (float)w_mat[count++];
    	}
        s[s_]->n=Psize;
        s[s_]->Features=f[s_];
        s[s_]->Weights=w[s_];
     }
	
	
	   
	e = emd3(s, size_, flow, &flowSize);
	
	plhs[0] = mxCreateDoubleMatrix((int)(*size)*((int)(*size)-1)/2, 1, mxREAL);

	out_matrix1 = mxGetPr(plhs[0]);
	for (int out=0;out<=(int)(*size)*((int)(*size)-1)/2;out++)
        out_matrix1[out] = (double)e[out];
    for (int s_=0;s_<size_; s_++)
    {
        delete(s[s_]);
        delete(f[s_]);
        delete(w[s_]);
    }
} // end (void) mexFunction

