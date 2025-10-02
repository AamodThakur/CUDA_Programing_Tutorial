### Longformer Slidding Window Algorithm

**Given:** Let we have 8 tokens and for simplicity we have 2 embedding size($d_{model}$)

<img width="316" height="125" alt="image" src="https://github.com/user-attachments/assets/e299d222-f2d9-4188-9104-bd575685499b" />

First, Second and Third matrices in above image are Q, K, V matrix respectively.
Here, we have 8 rows i.e. our tokens & we have 2 columns i.e. our embedding size($d_{model}$)
'1a' represents first embedding of first token and '1b' second embedding of first tokens.

**Assuming:** Window Size is 2, Number of Heads/Attention heads is 1 and Batch Size is 1.

Dimension of Q,K,V is [Batch Size, Sequence_Length, Number of Head, Embedding Dimension $d_{model}$] i.e. In this example [1, 8, 1, 2]

**Objective:** Our Final Attention Matrix 'S' i.e. $S = Q*K^T$ should look like,

<img width="200" height="157" alt="image" src="https://github.com/user-attachments/assets/0ca175df-350c-4f5c-a046-55fab23ab097" />

'11' represents first token multiplied with the first token. '21' represents second token multiplied with first token.
Causal Mask is not applied here. 

Similar to, 

<img width="400" height="347" alt="image" src="https://github.com/user-attachments/assets/4b1f3375-ef26-4546-8b84-381a17aa3b25" />

**Algorithm:** Using loops will consume more time than traditional self attention.

1. Calculate number of chunks (C)
```
C = Sequence_Length // w - 1 = 8 // 2 - 1 = 3
```

2. Reshape Q, K, V to [Batch Size * Number of Head, Sequence Length, $d_{model}$]

3. Review Dimension of Q and K to [Batch Size * Number of Head, Chunk, 2*w, $d_model}$]  --> Output of _chunk() function from https://github.com/allenai/longformer/blob/master/longformer/sliding_chunks.py



4. 

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
