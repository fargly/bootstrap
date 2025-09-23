#!/usr/bin/env -S uv run --script

import subprocess
import sys
import os

playbookdirectory: str = os.path.dirname(os.path.abspath(__file__))

# Define the list of playbooks to run
# Ensure these playbooks are in the same directory as the script, or provide their full path
playbooks = [
    # "/home/fargly/Projects/bootstrap/playbooks/HelloWorld.yaml",
    f"{playbookdirectory}/HelloWorld.yaml",
]

# Define common options for the ansible-playbook command
# -i specifies the inventory file
# inventory = "inventory.ini"
# common_options = ["-i", inventory]
common_options = []

"""
#!/usr/bin/env bash
uvx --from ansible-core ansible-playbook $@

## EOF
# """


def run_playbooks():
    """
    Iterates through and executes a list of Ansible playbooks.
    """
    for playbook in playbooks:
        print("---")
        print(f"Running playbook: {playbook}")
        print("---")

        # command = ["ansible-playbook", playbook] + common_options
        command = [
            # "/home/fargly/.local/bin/ansible-playbook",
            # f"{os.getenv('HOME')}/.local/bin/ansible-playbook",
            f"{os.getenv('HOME')}/.local/bin/uvx",
            "--from",
            "ansible-core",
            "ansible-playbook",
            playbook,
        ] + common_options

        try:
            # Execute the command and capture output
            result = subprocess.run(
                command,
                check=True,  # Raises an exception if the command fails
                capture_output=True,
                text=True,
            )
            print(result.stdout)
            print(f"✅ Playbook '{playbook}' completed successfully.\n")

        except subprocess.CalledProcessError as e:
            print(f"❌ ERROR: Playbook '{playbook}' failed.")
            print(f"Exit code: {e.returncode}")
            print(f"Stderr: {e.stderr}")
            sys.exit(1)  # Exit the script with an error code

    print("✅ All playbooks executed successfully.")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <EscalationPassword> <VaultPassword>")
        pass
    else:
        run_playbooks()
