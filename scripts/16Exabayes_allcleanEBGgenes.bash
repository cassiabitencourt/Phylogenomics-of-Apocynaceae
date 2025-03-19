#!/bin/bash
#
#SBATCH --chdir=/path/ExaBayes_files  # Change to the directory containing ExaBayes input files
#SBATCH --job-name=ExaBayesConcat  # Set the job name to 'ExaBayesConcat'
#SBATCH --partition=himem          # Use the 'himem' partition for high-memory tasks
#SBATCH --array=1                  # Run as a single task (job array with only one task)
#SBATCH --ntasks=2                 # Request 2 tasks
#SBATCH --cpus-per-task=8          # Allocate CPUs per task
#SBATCH --mem=64G                  # Allocate memory for the job
#SBATCH --mail-user=your@email.org  # Specify the email address for notifications
#SBATCH --mail-type=END,FAIL        # Send notifications when the job ends or fails

# Set the path to the ExaBayes executable
ExaBayes_EXEC=/path/apps/conda/bin/yggdrasil  # Path to ExaBayes binary

# Run ExaBayes with the specified parameters
$ExaBayes_EXEC -f Concatenated_Alignment.phy \   # Input concatenated alignment file in PHYLIP format
             -m DNA \                            # Specify DNA as the molecular data type
             -q Data_Partitions.phy \            # Provide a partition scheme file
             -n out \                            # Set output file prefix to 'out'
             -s 400000 \                         # Define the number of MCMC generations
             -c config_F.nex \                   # Use a configuration file for ExaBayes settings
             -M 0                                # Specify the memory mode (0 fastest but more memory consumption)