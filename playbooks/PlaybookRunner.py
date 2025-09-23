#!/usr/bin/env -S uv run --script

import subprocess
import sys
import os
from typing import List

playbookdirectory: str = os.path.dirname(os.path.abspath(__file__))
"""
AddConformUsers.yaml      ansible-posix.yaml              data.yaml                     FixChromeGnomeShortcutIssue.yaml  Linux_Chell_Audio_Fix.yaml  PlaybookRunner.py           Setup-PIN-Unlock.yaml  tailscale.yaml         ubuntu-gsettings-peripherals.yaml        WOL.yaml
AdditionalPackages.yaml   bootstrap.yaml                  DeCredentialTailscale.yaml    HelloWorld.yaml                   macos.yaml                  ReCredentialTailscale.yaml  starship_prompt.yaml   tmux-conf-local.patch  ubuntu-turn-off-automatic-upgrades.yaml
ansible_facts_print.yaml  chromebook-keyboard-Linux.yaml  DELETEME-escalation-password  incus_virtualization.yaml         neovim.yaml                 secret-management.yaml      SuperKeyRemap.yaml     TmuxMetaPlaybook.sh    webi-installs.yaml
ansible_pass.yaml         crostini_username.yaml          DELETEME-vault-password       InstallFiraNerdFont.yaml          omakub-nvim.yaml            secrets.yaml.vault          SuspendViaSSH.yaml     tmux.yaml              webi.yaml
"""

# Define the list of playbooks to run
# Ensure these playbooks are in the same directory as the script, or provide their full path
playbooks_list: List[str] = [
    "ansible_pass.yaml",
    "secret-management.yaml",
]

playbooks: List[str] = [f"{playbookdirectory}/{pb}" for pb in playbooks_list]

# Define common options for the ansible-playbook command
# -i specifies the inventory file
# inventory = "inventory.ini"
# common_options = ["-i", inventory]
common_options = []


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
            "--become-password-file",
            sys.argv[1],
            "--vault-password-file",
            sys.argv[2],
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

## EOF
