import os

def remove_R_from_header(header):
    return header.replace("_R_", "")

def process_fasta_file(file_name):
    modified_lines = []
    with open(file_name, 'r') as f:
        for line in f:
            if line.startswith(">"):
                modified_lines.append(remove_R_from_header(line))
            else:
                modified_lines.append(line)
    
    # Writing modified content back to the file
    with open(file_name, 'w') as f:
        for line in modified_lines:
            f.write(line)

def main():
    # List all files in the current directory
    files = os.listdir()
    fasta_files = [f for f in files if f.endswith('.fasta') or f.endswith('.fa')]
    
    for file_name in fasta_files:
        process_fasta_file(file_name)

if __name__ == "__main__":
    main()
