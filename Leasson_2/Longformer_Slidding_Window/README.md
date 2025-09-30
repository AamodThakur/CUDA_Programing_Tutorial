### Longformer Slidding Window Algorithm

**Given:** Let we have 8 tokens and for simplicity we have 2 embedding size($d_{model}$)

<img width="80" height="98" alt="image" src="https://github.com/user-attachments/assets/fbd4854f-7672-4070-973e-451c0363e404" />

Here, we have 8 rows i.e. our tokens & we have 2 columns i.e. our embedding size($d_{model}$)
'1a' represents first embedding of first token and '1b' second embedding of first tokens.

**Assuming:** Window Size is 2. 

**Objective:** Our Final Attention Matrix 'S' i.e. $S = Q*K^T$ should look like,



### Refrences
```
1. @misc{beltagy2020longformerlongdocumenttransformer,
      title={Longformer: The Long-Document Transformer}, 
      author={Iz Beltagy and Matthew E. Peters and Arman Cohan},
      year={2020},
      eprint={2004.05150},
      archivePrefix={arXiv},
      primaryClass={cs.CL},
      url={https://arxiv.org/abs/2004.05150}, 
}

2. https://github.com/allenai/longformer/blob/master/longformer/sliding_chunks.py

3. https://ahelhady.medium.com/understanding-longformers-sliding-window-attention-mechanism-f5d61048a907

```
