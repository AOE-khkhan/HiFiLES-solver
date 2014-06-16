#####################################################
# \file configure_run.sh
# \brief Configuration script for HiFiLES
# \author - Original code: SD++ developed by Patrice Castonguay, Antony Jameson,
#                          Peter Vincent, David Williams (alphabetical by surname).
#         - Current development: Aerospace Computing Laboratory (ACL)
#                                Aero/Astro Department. Stanford University.
# \version 0.1.0
#
# High Fidelity Large Eddy Simulation (HiFiLES) Code.
# Copyright (C) 2014 Aerospace Computing Laboratory (ACL).
#
# HiFiLES is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# HiFiLES is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with HiFiLES.  If not, see <http://www.gnu.org/licenses/>.
#####################################################
# Standard (Helpful) Settings [Should not need to change these]
HIFILES_HOME=$(pwd)
HIFILES_RUN=$(pwd)/bin
# ---------------------------------------------------------------
# Basic User-Modifiable Build Settings [Change these as desired]
NODE="CPU"              # CPU or GPU
CODE="DEBUG"            # DEBUG or RELEASE
BLAS="ATLAS"            # ATLAS, STANDARD, ACCLERATE, MKL, or NO
PARALLEL="no"           # MPI or NO
TECIO="no"              # YES or NO
# ---------------------------------------------------------------
# Compiler Selections [Change compilers or add full filepaths if needed]
CXX="g++"               # Typically g++ (default) or icpc (Intel)
NVCC="nvcc"             # NVidia CUDA compiler
MPICC="mpicxx"          # MPI compiler
# ---------------------------------------------------------------
# Library Locations [Change filepaths as needed]
BLAS_LIB="/usr/lib/atlas-base"
BLAS_INCLUDE="/usr/include"

PARMETIS_LIB="/usr/local/lib"
PARMETIS_INCLUDE="/usr/local/include"

METIS_LIB="/usr/local/lib"
METIS_INCLUDE="/usr/local/include"

TECIO_LIB="lib/tecio-2008/lib"
TECIO_INCLUDE="lib/tecio-2008/include"

CUDA_LIB="/usr/local/cuda/lib64"
CUDA_INCLUDE="/usr/local/cuda/include"

# Build ParMETIS from HiFiLES library folder?
METIS="yes"

# MPI header location (mpi.h needed for Metis)
MPI_INCLUDE="/usr/include/mpich2"

# ---------------------------------------------------------------
# Run configure using the chosen options [Should not change this]
if [[ "$NODE" == "GPU" ]]
then
    _GPU=$NVCC
else
    _GPU="no"
fi
if [[ "$PARALLEL" == "MPI" ]]
then
    _MPI=$MPICC
else
    _MPI="no"
    PARMETIS_LIB="no"
    PARMETIS_INCLUDE="no"
fi
if [[ "$TECIO" == "no" ]]
then
    TECIO_LIB="no"
    TECIO_INCLUDE="no"
fi
./configure --prefix=$HIFILES_RUN/.. \
            --with-CXX=$CXX \
            --with-BLAS=$BLAS \
            --with-BLAS-lib=$BLAS_LIB \
            --with-BLAS-include=$BLAS_INCLUDE \
            --with-MPI=$_MPI \
            --with-MPI-include=$MPI_INCLUDE \
            --with-CUDA=$_GPU \
            --with-CUDA-lib=$CUDA_LIB \
            --with-CUDA-include=$CUDA_INCLUDE \
            --with-ParMetis-lib=$PARMETIS_LIB \
            --with-ParMetis-include=$PARMETIS_INCLUDE \
            --with-Metis-lib=$METIS_LIB \
            --with-Metis-include=$METIS_INCLUDE \
            --with-Tecio-lib=$TECIO_LIB \
            --with-Tecio-include=$TECIO_INCLUDE \
            --enable-metis=$METIS
