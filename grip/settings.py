# Create personal access token at https://github.com/settings/tokens/new
# Do not include any scopes, i.e. read only access to public information
# Save access token to keychain using the following cli/shell command:
#
#   security add-generic-password -a grip -s github -w
#
# When you hit enter you will be prompted to enter the access token

def find_password():
    import subprocess
    import shlex
    cmd = "security find-generic-password -a grip -s github -w"
    res = subprocess.run(shlex.split(cmd), capture_output=True)
    if res.returncode != 0:
        print("{}: Personal access token not found".format(__file__))
        print("Command failed: {}".format(cmd))
        print(res.stderr.decode())
        return
    return res.stdout.decode().strip()

PASSWORD = find_password()
