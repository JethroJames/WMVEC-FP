# Adaptive Weighted Multi-View Evidential Clustering With Feature Preference (WMVEC-FP)

🖐️Welcome to the official repository for the research paper "Adaptive Weighted Multi-View Evidential Clustering With Feature Preference" as published in Knowledge-Based Systems. This repository includes MATLAB code, datasets, and additional resources used and described in our paper.

## Paper Abstract

Multi-view clustering has attracted substantial attention thanks to its ability to integrate information from diverse views. Our proposed Adaptive Weighted Multi-View Evidential Clustering (WMVEC) method, based on the theory of belief functions, characterizes the uncertainty and imprecision in cluster assignment. By integrating view weight assignments and credal partitions, our approach enables objects to be associated not only with singleton clusters but also subsets of these clusters (meta-clusters) and an empty set representing noise. Additionally, WMVEC with Feature Preference (WMVEC-FP) addresses the relevance of each feature under different views, ensuring enhanced performance and relevance in clustering tasks.

## Publication

🔥This work is published in the Knowledge-Based Systems journal:

- **Title**: Adaptive Weighted Multi-View Evidential Clustering With Feature Preference
- **Authors**: Zhe Liu, Haojian Huang, Sukumar Letchmunan, Muhammet Deveci
- **Journal**: Knowledge-Based Systems, Volume 294, 2024, Pages 111770
- **DOI**: [10.1016/j.knosys.2024.111770](https://doi.org/10.1016/j.knosys.2024.111770)
- **Read the paper here**: [ScienceDirect Link](https://www.sciencedirect.com/science/article/pii/S0950705124004052)

🧰## Contributions
We welcome contributions to our project! If you have suggestions or improvements regarding our code or methodologies, please feel free to fork this repository and submit a pull request.

For any questions or issues, please open an issue on this repository, and we will do our best to address it promptly.

## Citing This Work

If you use our method or this repository in your research, please cite our paper. Here is the citation in BibTeX format:

```bibtex
@article{LIU2024111770,
  title = {Adaptive weighted multi-view evidential clustering with feature preference},
  journal = {Knowledge-Based Systems},
  volume = {294},
  pages = {111770},
  year = {2024},
  issn = {0950-7051},
  doi = {https://doi.org/10.1016/j.knosys.2024.111770},
  url = {https://www.sciencedirect.com/science/article/pii/S0950705124004052},
  author = {Zhe Liu and Haojian Huang and Sukumar Letchmunan and Muhammet Deveci},
  keywords = {Evidential clustering, Multi-view learning, Theory of belief functions, Credal partition},
  abstract = {Multi-view clustering has attracted substantial attention thanks to its ability to integrate information from diverse views. However, the existing methods can only generate hard or fuzzy partitions, which cannot effectively represent the uncertainty and imprecision when facing objects in overlapping clusters, thus increasing the risk of error. To solve the above problems, in this paper, we propose an adaptive weighted multi-view evidential clustering (WMVEC) method based on the theory of belief functions to characterize the uncertainty and imprecision in cluster assignment. Technically, we integrate view weight assignments and credal partition between objects and cluster prototypes into a joint learning framework. The credal partition offers a more comprehensive insight into the data by enabling objects to be associated with not only singleton clusters but also subsets of these clusters (termed meta-clusters) and the empty set, which represents a noise cluster. To avoid the interference of irrelevant and redundant features, we further present a weighted multi-view evidential clustering with feature preference (WMVEC-FP) to learn the importance of each feature under different views. We suggest the objective functions of WMVEC and WMVEC-FP and design alternating optimization schemes to obtain the optimal solutions, respectively. Through an extensive array of experiments, it has been demonstrated that our proposed clustering methods outperform other related and state-of-the-art methods in terms of their advantages and overall effectiveness.}
}



