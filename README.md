
# bootstrap

Minimal Bootstraping Sequence using Webi/Uvx/Ansible

## macOS and Linux

```bash
curl https://raw.githubusercontent.com/fargly/bootstrap/main/scripts/bootstrap.sh | sh
```

## Forking Notes

This bootstrapping process is obiviously highly opinionated. If you fork this repo, think of it as a starting point to express your own use case. There is an Ansible Vault file in the playbooks directory, 'secrets.yaml.vault', which will need to be replaced with your own vault file with contents.

I'm not currently in an Enterprise environment so bootstrapping is very PULL oriented instead of the usual Ansible PUSH paradigm. I'm attempting to standardize my dev environment without a large amount of manual work. I utilized astral.sh uv utility extensively to avoid a large amount of sysadmin busy work.

## Notes
* All tasks in bootstrap hierarchy that require privilege are tagged 'privileged'. You may issue a '--skip-tags "privileged"' argument to run all tasks in a playbook that don't require privilege.
