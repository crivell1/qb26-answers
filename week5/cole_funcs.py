import numpy as np
from unsupervised_framework import align_times, plot_hm, normalize_data
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans


def pca_from_data(data):
    #function to load data, perform PCA, and plot the first 2 PCs
    
    genes = np.array([name.rstrip() for name in open('gene_names.txt')])
    sample_labels = np.array([name.rstrip().split('\t') for name in open('samples.txt')])
    times = np.array([int(time.split('_')[1]) for time, rep in sample_labels if rep == 1], dtype=np.int32)
    rep_times = np.array([int(time.split('_')[1]) for time, rep in sample_labels], dtype=np.int32)
    reps = np.array([int(rep.split('_')[1]) for time, rep in sample_labels], dtype=np.int32)

    ## The above was all provided

    rep_pca = PCA(2, random_state=42).fit_transform(data.T) ## the instructions say to do all of these steps
    # print(rep_pca) # Good 'ol print debugging
    plt.scatter(rep_pca[:, 0], rep_pca[:, 1], c=rep_times, cmap='Set1', s=reps*15) ## looked up matplotlib scatter function and it showed the following
    plt.title('PCA of Replicate Data (1.3)')
    plt.xlabel('PC1')
    plt.ylabel('PC2')
    plt.show()

def ex_2():
    #function to calc means and std, perform PCA, and plot the first
    nf_rep_data = np.loadtxt('WT_NF_Ctrl_rep_counts.tsv')
    rapa_data = np.loadtxt('WT_NF_Rapa_counts.tsv')
    nf_data = np.loadtxt('WT_NF_Ctrl_counts.tsv')

    genes = np.array([name.rstrip() for name in open('gene_names.txt')])
    sample_labels = np.array([name.rstrip().split('\t') for name in open('samples.txt')])
    times = np.array([int(time.split('_')[1]) for time, rep in sample_labels if rep == 1], dtype=np.int32)
    rep_times = np.array([int(time.split('_')[1]) for time, rep in sample_labels], dtype=np.int32)
    reps = np.array([int(rep.split('_')[1]) for time, rep in sample_labels], dtype=np.int32)

    ## The above was all provided
    # print(nf_rep_data)

    ref_means = np.mean(nf_rep_data, axis = 1)
    ref_std = np.std(nf_rep_data, axis = 1)
    nf_means = np.mean(nf_data,axis = 1)
    nf_std = np.std(nf_data,axis = 1)
    rapa_means = np.mean(rapa_data,axis = 1)
    rapa_std = np.std(rapa_data,axis = 1)

    # print(nf_rep_data.shape, ref_means.shape, ref_std.shape)

    # Make boolean arrays for filtering - if above a value it'll replace it with TRUE
    ref_bool = ref_means > 0.85 
    ref_bool = ref_bool & (ref_std/ref_means > 0.115)
    nf_bool = nf_means > 0.85
    nf_bool = nf_bool & (nf_std/nf_means > 0.115)
    rapa_bool = rapa_means > 0.85
    rapa_bool = rapa_bool & (rapa_std/rapa_means > 0.115)

    filtered_ref = nf_rep_data[ref_bool,:] 
    filtered_nf = nf_data[nf_bool,:]
    # I had originally filtered all of these individually but was getting an index error later in 3.2 because the genes didn't match up between the ctrl and the rapa arrays. So I filtered the rapa data based on the boolean array from the ctrl data so that they would match up. I think this is what the instructions were asking for.
    filtered_rapa = rapa_data[nf_bool,:]

    pca2 = PCA(2, random_state=42).fit_transform(filtered_ref.T)
    plt.scatter(pca2[:, 0], pca2[:, 1], c=rep_times, cmap='Set1', s=reps*15)
    plt.title('PCA of FILTERED Replicate Data (2.1)')
    plt.xlabel('PC1')
    plt.ylabel('PC2')
    plt.show()
    return filtered_ref, filtered_nf, filtered_rapa

def ex_2_2(gene_data, color_array):

    normalized_data = normalize_data(gene_data)
    peak = np.argmax(normalized_data, axis=1) ## what timepoint each gene peaks at
    if color_array is None:
        color_array = peak ## color array is the timepoint each gene peaks at
    # ^ I wasn't sure if I was supposed to use the color_array argument or not since I normalized in the function, but I think this is what the instructions were asking for

    coordinates = PCA(2, random_state=42).fit_transform(normalized_data) ## the instructions say to do all of these steps
    plt.scatter(coordinates[:, 0], coordinates[:, 1], c=color_array, cmap='Set1') ## looked up matplotlib scatter function and it showed the following
    plt.title('PCA of Gene Data 2.3')
    plt.xlabel('PC1')
    plt.ylabel('PC2') 
    plt.show()
    return coordinates

def angle_calc(data, gene_coords):
    #function to calculate the angle of each gene in PCA space
    angles = np.arctan2(gene_coords[:, 1], gene_coords[:, 0]) ## arctan2(y,x) gives the angle in radians
    norm_data = normalize_data(data)
    plot_hm(norm_data, xlabel='Timepoint', ylabel='Genes', title='Genes in PCA space ordered by angles (3.1)', orderby=angles, showgroups=False, fname=None)
 
    return angles

def align_data_with_angles(gene_coords, angles, plot = False):
    #function to align all genes by their angles
    aligned = align_times(gene_coords, angles) ## align the genes by their angles
    if plot == True:
        plot_hm(aligned, xlabel='Timepoint', ylabel='Genes', title='Genes in PCA space aligned by angles', orderby=None, showgroups=False, fname=None)#I just saved the png through the save button because I didn't want to deal with the file path issues. I can add it in if you want me to.
    return aligned

def cluster_and_plot(data1, data2):
    #function to cluster the data and plot the heatmap
    data = np.concatenate((data1, data2), axis=1) ## combine the two datasets
    
    kmeans = KMeans(n_clusters=6, random_state=42)

    groups = kmeans.fit_predict(data) ## fit the model and predict the clusters

    plot_hm(data1, data2, xlabel='aligned timepoints', ylabel='genes', title='KMeans Clustering of Aligned Data', orderby=groups, showgroups=True, fname=None)

# Run the functions! 

ctrl_data = np.loadtxt('WT_NF_Ctrl_rep_counts.tsv')

pca_from_data(ctrl_data)

filtered_ref, filtered_nf, filtered_rapa = ex_2()

nf_ctrl_pca_coords = ex_2_2(filtered_nf, color_array = None)
nf_rep_pca_coords = ex_2_2(filtered_ref, color_array = None)
nf_rapa_pca_coords = ex_2_2(filtered_rapa, color_array = None)

nf_ctrl_angles = angle_calc(filtered_nf, nf_ctrl_pca_coords)

# for 3.2 I had to add int() within the helper function because I was getting an error about the roll function not accepting float values. 
nf_wt_aligned = align_data_with_angles(normalize_data(filtered_nf), nf_ctrl_angles, plot = True)
nf_rapa_aligned = align_data_with_angles(normalize_data(filtered_rapa), nf_ctrl_angles)

cluster_and_plot(nf_wt_aligned, nf_rapa_aligned)


## QUESTION - ANSWERS

## EX 1
# The replicates do cluster together by sampling time but not by replicate number. This is what we would expect because the replicates are supposed to be similar to each other at the same timepoint, but not necessarily similar to other timepoints.

## EX 2
# The plot looks almost exactly the same - just a little tighter together on both axes


# I'm going to be honest, I don't fully understand the analysis from exercise 3.
# Are we just assuming the angles correlates with the timepoint since we know these are representing time-dependent genes?
# I'm not totally sure what "phased to the same timing" means
