import os

print("Retrieve and print all DEMO environment variables")
for key, value in os.environ.items():
    if key.startswith("DEMO_"):
        print(f"{key}: {value}")

# Specify the directory path
directory_path = "/secret/"

# Check if the directory exists
if os.path.exists(directory_path) and os.path.isdir(directory_path):
    print("Ssssssh! Secrets:")
    # List all files in the directory
    files = os.listdir(directory_path)

    # Iterate over each file and print its contents
    for file_name in files:
        file_path = os.path.join(directory_path, file_name)
        # Ensure it's a file (not a subdirectory)
        if os.path.isfile(file_path):
            print(f"Contents of {file_name}:")
            with open(file_path, "r") as file:
                print(file.read())
else:
    print(f"The directory {directory_path} does not exist.")
