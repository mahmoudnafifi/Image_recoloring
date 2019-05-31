#include <stdlib.h>
#include "mex.h"
#include "emd__.cpp"


//in Matlab:
//call [distance,flow]=EMD_(features1,feature2,weights1,weights2);
// distance(1) = EMD, distance(2) = flowSize
// flow (flowSize*3) matrix. Each row contains [from, to, amount of work]
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	
	feature_t *f1, *f2;
	float *w1, *w2;
	signature_t s1, s2;
	float       e;
	flow_t      *flow;
	int      flowSize;
	
	double *f1_mat, *f2_mat;
	double *w1_mat, *w2_mat;
	mwSize palette1_size, palette2_size;
	double *out_matrix1, *out_matrix2;
	
	int i, j;
	
	palette1_size = mxGetM(prhs[0]);
	palette2_size = mxGetM(prhs[1]);
	f1_mat = mxGetPr(prhs[0]); // each row is a Lab color
	f2_mat = mxGetPr(prhs[1]); // each row is a Lab color
	w1_mat = mxGetPr(prhs[2]);
	w2_mat = mxGetPr(prhs[3]);
	flow = new flow_t[palette1_size + palette2_size];
	
	f1 = new feature_t[palette1_size];
	w1 = new float[palette1_size];
	for (i=0; i<palette1_size; i++)
	{
		f1[i].X = f1_mat[                    i];
		f1[i].Y = f1_mat[palette1_size     + i];
		f1[i].Z = f1_mat[palette1_size * 2 + i];
		w1[i] = (float)w1_mat[i];
		
	}
	
	f2 = new feature_t[palette2_size];
	w2 = new float[palette2_size];
	for (i=0; i<palette2_size; i++)
	{
		f2[i].X = f2_mat[                    i];
		f2[i].Y = f2_mat[palette2_size     + i];
		f2[i].Z = f2_mat[palette2_size * 2 + i];
		w2[i] = (float)w2_mat[i];
	}
	
	s1 = { palette1_size, f1, w1 };
	s2 = { palette2_size, f2, w2 };
	   
	e = emd1(&s1, &s2, flow, &flowSize);
	
	plhs[0] = mxCreateDoubleMatrix(2, 1, mxREAL);
	out_matrix1 = mxGetPr(plhs[0]);
	out_matrix1[0] = (double)e;
	out_matrix1[1] = (double)flowSize;
	
	plhs[1] = mxCreateDoubleMatrix(flowSize, 3, mxREAL);
	out_matrix2 = mxGetPr(plhs[1]);
	for (i = 0; i < flowSize; i++)
		//if (flow[i].amount > 0)
		{
			out_matrix2[               i] = flow[i].from;
			out_matrix2[flowSize     + i] = flow[i].to;
			out_matrix2[flowSize * 2 + i] = flow[i].amount;
		}
    delete(f1); delete(f2);
    delete(w1); delete(w2);

} // end (void) mexFunction

