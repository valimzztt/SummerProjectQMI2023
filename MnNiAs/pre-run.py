from clease.settings import CECrystal, Concentration
import json
#define concentration range of all elements
from clease.settings import Concentration
conc = Concentration(basis_elements=[['Mn', 'Ni'], ['As']])
conc.set_conc_ranges(ranges=[[(0,1),(0,1)], [(1,1)]])

from clease.settings import CECrystal

settings = CECrystal(concentration=conc,
    spacegroup=194,
    basis=[(0.00000, 0.00000, 0.00000), (0.33333333, 0.66666667, 0.25)],
    cell=[3.64580405, 3.64580405,   5.04506600, 90, 90, 120],
    size=(2,1,1),
    db_name="MnNiAs_conv.db",
    basis_func_type='binary_linear',
    max_cluster_dia=(7,7,7))


#generate first round of structures
from clease import NewStructures
ns = NewStructures(settings, generation_number=0, struct_per_gen=2)
ns.generate_initial_pool()

from clease.settings import Concentration
import os 
from ase.build import sort
from ase.io import vasp, db
import sys
from ase.db import connect

db_name = "MnNiAs_conv.db"
#db_name = "clease.db"
db = connect(db_name)
count = 0
# Let's create a database that contains only converged structures
for row in db.select(id=3):
    atoms=db.get(id=3).toatoms()
    print(atoms)
    changed = 0
    for i in range(0,len(atoms),1):
        if atoms[i].symbol=='Mn' and changed == 0:
            atoms[i].symbol='Ni'
            changed == 1
    print(atoms)
    db.write(atoms, converged=False)