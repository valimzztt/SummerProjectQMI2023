#!/bin/sh
module purge
module add impi sci/dft sci

NAME="ecut"
declare -A energy_dict  # Declare an associative array for storing energies
declare -A cpu_dict  # Declare an associative array for storing CPU time

for CUTOFF in 400 450 500 550
do
WORK_DIR="$PWD/${NAME}${CUTOFF}"
mkdir $WORK_DIR

echo ${WORK_DIR}
cp POSCAR ${WORK_DIR}
cp POTCAR ${WORK_DIR}
cp KPOINTS ${WORK_DIR}
cd $WORK_DIR

cat > INCAR << EOF
INCAR created by Atomic Simulation Environment
 ENCUT = $CUTOFF
 KSPACING = 0.400000
 SIGMA = 0.050000
 EDIFF = 1.00e-06
 EDIFFG = -2.00e-02
 GGA = PS
 PREC = Accurate
 IBRION = 2
 ISIF = 3
 ISMEAR = 0
 ISPIN = 1
 ISTART = 0
 ISYM = 0
 NSW = 50
 NCORE = 4
 LASPH = .TRUE.
 LSCALAPACK = .FALSE.
 LWAVE = .FALSE.
 LREAL = .FALSE.
EOF

mpirun -np 4 vasp > vasp_output.txt 2>&1
wait
 

energy=$(awk '/free  energy   TOTEN/ { energy = $5 } END { print energy }' "OUTCAR")
cpu_time=$(awk '/Total CPU time used/ { gsub(/[()]/, "", $NF); print $NF }' "OUTCAR")
echo ${energy}
echo "$CUTOFF, $energy, $cpu_time" >> "results.csv"  # Append data to CSV file
energy_dict["${CUTOFF}"]=$energy  # Store energy in the dictionary with cutoff value as key
cpu_dict["${CUTOFF}"]=$cpu_time  # Store cpu time in the dictionary with cutoff value as key

#Clean up
cd - 
rm -r ${WORK_DIR}
done

# Print the dictionary
for key in "${!energy_dict[@]}"; do
    echo "CUTOFF: $key, Energy: ${energy_dict[$key]}"
    echo "CUTOFF: $key, CPU TIME: ${cpu_dict[$key]}"
    # Save energies in text file with corresponding cutoff
    echo "$key ${energy_dict[$key]}" >> "energies.txt"
    echo "$key ${cpu_dict[$key]}" >> "energies.txt"
done
