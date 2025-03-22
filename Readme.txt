
Code used during simulations in:

Luna, R., Serrano-Pedraza, I., & Bertalmío, M. (2025). Overcoming the limitations of motion sensor models by considering dendritic computations. 
Scientific Reports, 15(1), 9213.



In order to perform simulations related to:

-Detection of first-order motion (Figure 3):
run the script "Polarity_response_bar.m" 

-Contrast saturation (Figure 4):
run the script "Contrast_response.m"

-Motion masking (Figure 5):
run the script "Masking_response.m"
(to reproduce the results in Figure 5a, set "LGN=0" [Line 37])
(to reproduce the results in Figure 5a, set "LGN=1" [Line 37])

-Reverse-phi motion (Figure 6a):
run the script "Reverse_phi_response.m"

-Missing-fundamental illusion (Figure 6b):
run the script "Missing_fundamental_response.m"

-The proposed model also detects second-order motion (Figure 7):
run the script "Second_order_response"

-The proposed model is highly nonlinear (Figure 8):
run the script "Spatio_temporal_response.m" (may take a couple of hours)
then run the script "Spatio_temporal_response_complex.m" (may take ten times longer than "Spatio_temporal_response.m" to run)
By running the aforementioned scripts, the files "SpatioTemporal_map_1stOrder" and "SpatioTemporal_map_complex" are generated
then run the script "Represent_map_log.m" within the folder named "SpatioTemporal_maps"
(to reproduce the results in Figure 8a, set "single_vs_complex=0"  [Line 6])
(to reproduce the results in Figure 8b, set "single_vs_complex=1"  [Line 6])

