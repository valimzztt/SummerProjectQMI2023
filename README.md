# Summer Project QMI 2023
Repository that collects Density Functional Theory (DFT) calculations, Cluster Expansion (CE) and Monte Carlo simulations to investigate the magnetically segregated nano layering in (Mn,Ni)As and extending the search of layering to other similar systems.

# Historical background
In 1986, researchers conducted an investigation into the structure and phase transitions of the intermediate solid solution found between MnAs and NiAs, referred to as 𝑀n_(1−𝑥)𝑁𝑖_𝑥 As. They utilized powder X-ray diffraction and neutron diffraction techniques. The study of the structural and magnetic properties of the ternary (pseudo-binary) 𝑀𝑛𝑁𝑖𝐴𝑠 system revealed a diverse phase diagram for 𝑀n_(1−𝑥)𝑁𝑖_𝑥 As, characterized by various transitions resulting in different magnetic and crystal structure properties. Particularly noteworthy was the discovery of an intriguing structural phenomenon within the composition range of $0.25 < x < 0.75$ for the intermediate solid solution between MnAs and NiAs.

Following the preparation of this solid solution, involving a four-week annealing process at 600 degrees Celsius, subsequent powder neutron diffraction unveiled a pronounced superstructure reflection at relatively low scattering angles. This finding suggested the presence of additional satellite reflections, which were attributed to an ordering phenomenon associated with the arrangement of metal atoms. The paper concluded with an unanswered question regarding the nature of the crystallographic superstructure in 𝑀n_(1−𝑥)𝑁𝑖_𝑥As—whether it exhibited incommensurate characteristics with smooth compositional variations of periodicity or represented a locked-in commensurate arrangement.

Moving to 2020, researchers leveraged advanced tools for crystal-structure analysis to revisit the 𝑀n_(1−𝑥)𝑁𝑖_𝑥As solid solution, specifically focusing on the Mn0.60Ni0.40As sample. Their findings confirmed the presence of an incommensurate compositional modulation at the nano-level. Manganese and nickel displayed periodic segregation into ordered MnAs and NiAs layers, each layer with a thickness of 2–4 face-shared octahedra. Notably, MnAs exhibited ferromagnetic properties, while NiAs remained paramagnetic, implying potential applications in the field of spintronics.

The intrinsic "nano-layering" observed in $Mn0.60Ni0.40As$ was unique. While a few related features existed in the literature, none matched the extent of occupational modulation of Mn and Ni in Mn0.60Ni0.40As, leading to complete segregation into MnAs and NiAs regions. This periodic variation in the stacking of 2D layers of MnAs and NiAs created an incommensurate modulation.

Subsequently, in 2021, the same research group published another paper demonstrating the existence of single-phase $Mn1–xNixAs$ ($0.25 ≤ x ≤ 0.50$) using a rigorous methodology. This unique intrinsic nano structuring allowed for the tuning of the thickness of MnAs and NiAs nanolayers through changes in composition, x. Additionally, they probed the 3d magnetic moments of Mn and Ni, revealing distinct differences. The magnetic moment of manganese was found to be one order of magnitude greater than that of nickel. This study paves the way for a new class of materials with intrinsic layers of varying magnetization, with potential applications in spintronics. Once again, the researchers emphasized the suitability of this intrinsically nanolayered material for advancing spintronics applications, given MnAs' ferromagnetic nature and NiAs' paramagnetic behavior.



# Studying the thermodynamics of (Mn,Ni)AS system
Since we only vary the Mn to Ni ratio, while keeping As fixed, the material system can be viewed as pseudo-binary. The reason for choosing Mn-Ni-As as a model system is motivated by the recent discovery of Magnetically Segregated Nanolayering in Mn-Ni-As intermetallics. 

Reference paper:
1. https://pubs.acs.org/doi/pdf/10.1021/acs.chemmater.1c00760

Functionality: 
-------------
The repository currently includes the following functionality:
1. Generate either random or special quasi random structures (SQS) that will provide the fitting data to perform cluster expansion.
2. Perform DFT using VASP on the generated structures: computed energies are stored in an ASE database (of the form SQLite) as well as a ComputedEnergyEntry class provided by the Pymatgen package
3. Perform cluster expansion using CLEASE or SMOL


Required packages: 
-------------
-   **smol** is a minimal implementation of computational methods to calculate
statistical mechanical and thermodynamic properties of crystalline
material systems based on the *cluster expansion* method from alloy theory and
related methods (https://cedergrouphub.github.io/smol/)
-   **pymatgen**  
-   **clease**  

## Important considerations: 
### Choosing between random and SQS:
1. Pros:  SQS generation is the best periodic supercell approximations to the true disordered state for a given number of atoms per supercell. The method is based on a Monte Carlo simulated annealing loop with an objective function that seeks to
perfectly match the maximum number of correlation functions (as opposed to merely minimizing the
distance between the SQS correlation and the disordered state correlations for a pre-specified set of
correlations). SQS are optimal according to the criterion that a specified set of correlations between neighboring
site occupations in the SQS match the corresponding correlation of the true, fully disordered, state.The method optimizes the shape of the supercell jointly with the occupation of
the atomic sites, thus ensuring that the configurational space searched is exhaustive and not biased by a
pre-specified supercell shape. 

2. Cons: literature reported different predicted properties based on different initial SQS. 

### Truncation of the CE expansion: 
 An unsuccessfully truncated CE model due to a limited number of considered training structures may explain the discrepancy in why CE fails to predict the correct outcome in ref. 31. Such inconsistency demonstrates the importance of using an appropriately truncated CE model when studying the mixing of metals in MAX phases.


## Cluster expansion formalism: 
Reference paper: https://www.nature.com/articles/s41524-023-00971-3

An alternative to the computationally demanding crystal structure prediction (CSP) method is the use of methods such as CE which, in contrast to CSP, requires an a priori defined crystal structure. The expansion is carried out on one or multiple sublattices where parameterization is used to express the configurational dependence of physical properties such as energy27, band gap28,29, and magnetic interactions.

### Limitations of CE: 
Despite CE being computationally efficient it is limited by its dependence on an a priori defined input structure, which limits the considered chemical phase space. It would be interesting to combine CE with CSP so that the drawbacks of each method can be eliminated reciprocally. CE and CSP offers an efficient framework that yields reliable results when searching for low-energy basins as the drawbacks of each framework cancel out. The CSP is herein initially used to identify input structures for the CE models whereas the latter is used to explore the mixing and/or stability tendencies in (Mn,Ni)As

The limitations of the cluster expansion formalism when used to pave the path towards stable and possibly synthesizable materials is the restriction defined by the input structure. Relying on an input structure may hinder the exploration of the phase space. Using CE alone is thus prone to miss valuable information hidden within the complete chemical space. An alternative approach that may circumvent this problem, and where the dependence of any initial structure is of lesser importance, or even neglected, is thus preferred. [CITATION NEEDED]
